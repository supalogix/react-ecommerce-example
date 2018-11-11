-- DATABASE INITIALIZATION -----------------------------------------------------
--
-- The following code performs the initial setup of the PostgreSQL database with
-- required objects for the anchor database.
--
--------------------------------------------------------------------------------
-- create schema
CREATE SCHEMA IF NOT EXISTS dbo;
-- set schema search path
SET search_path = dbo;
-- drop universal function that generates checksum values
-- DROP FUNCTION IF EXISTS dbo.generateChecksum(text);
-- create universal function that generates checksum values
CREATE OR REPLACE FUNCTION dbo.generateChecksum(
    value text
) RETURNS bytea AS '
    BEGIN
        return cast(
            substring(
                MD5(value) for 16
            ) as bytea
        );
    END;
' LANGUAGE plpgsql;
-- KNOTS --------------------------------------------------------------------------------------------------------------
--
-- Knots are used to store finite sets of values, normally used to describe states
-- of entities (through knotted attributes) or relationships (through knotted ties).
-- Knots have their own surrogate identities and are therefore immutable.
-- Values can be added to the set over time though.
-- Knots should have values that are mutually exclusive and exhaustive.
-- Knots are unfolded when using equivalence.
--
-- KNOT TRIGGERS ---------------------------------------------------------------------------------------------------
--
-- The following triggers enable calculation and storing checksum values.
--
-- ANCHORS AND ATTRIBUTES ---------------------------------------------------------------------------------------------
--
-- Anchors are used to store the identities of entities.
-- Anchors are immutable.
-- Attributes are used to store values for properties of entities.
-- Attributes are mutable, their values may change over one or more types of time.
-- Attributes have four flavors: static, historized, knotted static, and knotted historized.
-- Anchors may have zero or more adjoined attributes.
--
-- Anchor table -------------------------------------------------------------------------------------------------------
-- PR_Product table (with 2 attributes)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._PR_Product;
CREATE TABLE IF NOT EXISTS dbo._PR_Product (
    PR_ID serial not null, 
    PR_Dummy boolean null,
    constraint pkPR_Product primary key (
        PR_ID
    )
);
ALTER TABLE IF EXISTS ONLY dbo._PR_Product CLUSTER ON pkPR_Product;
-- DROP VIEW IF EXISTS dbo.PR_Product;
CREATE OR REPLACE VIEW dbo.PR_Product AS SELECT 
    PR_ID,
    PR_Dummy
FROM dbo._PR_Product;
-- Historized attribute table -----------------------------------------------------------------------------------------
-- PR_NAME_Product_Name table (on PR_Product)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._PR_NAME_Product_Name;
CREATE TABLE IF NOT EXISTS dbo._PR_NAME_Product_Name (
    PR_NAME_PR_ID int not null,
    PR_NAME_Product_Name varchar(64) not null,
    PR_NAME_ChangedAt timestamp not null,
    constraint fkPR_NAME_Product_Name foreign key (
        PR_NAME_PR_ID
    ) references dbo._PR_Product(PR_ID),
    constraint pkPR_NAME_Product_Name primary key (
        PR_NAME_PR_ID,
        PR_NAME_ChangedAt
    )
);
ALTER TABLE IF EXISTS ONLY dbo._PR_NAME_Product_Name CLUSTER ON pkPR_NAME_Product_Name;
-- DROP VIEW IF EXISTS dbo.PR_NAME_Product_Name;
CREATE OR REPLACE VIEW dbo.PR_NAME_Product_Name AS SELECT
    PR_NAME_PR_ID,
    PR_NAME_Product_Name,
    PR_NAME_ChangedAt
FROM dbo._PR_NAME_Product_Name;
-- Static attribute table ---------------------------------------------------------------------------------------------
-- PR_ID_Product_Uuid table (on PR_Product)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._PR_ID_Product_Uuid;
CREATE TABLE IF NOT EXISTS dbo._PR_ID_Product_Uuid (
    PR_ID_PR_ID int not null,
    PR_ID_Product_Uuid uuid not null,
    constraint fkPR_ID_Product_Uuid foreign key (
        PR_ID_PR_ID
    ) references dbo._PR_Product(PR_ID),
    constraint pkPR_ID_Product_Uuid primary key (
        PR_ID_PR_ID
    )
);
ALTER TABLE IF EXISTS ONLY dbo._PR_ID_Product_Uuid CLUSTER ON pkPR_ID_Product_Uuid;
-- DROP VIEW IF EXISTS dbo.PR_ID_Product_Uuid;
CREATE OR REPLACE VIEW dbo.PR_ID_Product_Uuid AS SELECT
    PR_ID_PR_ID,
    PR_ID_Product_Uuid
FROM dbo._PR_ID_Product_Uuid;
-- TIES ---------------------------------------------------------------------------------------------------------------
--
-- Ties are used to represent relationships between entities.
-- They come in four flavors: static, historized, knotted static, and knotted historized.
-- Ties have cardinality, constraining how members may participate in the relationship.
-- Every entity that is a member in a tie has a specified role in the relationship.
-- Ties must have at least two anchor roles and zero or more knot roles.
--
-- ATTRIBUTE RESTATEMENT CONSTRAINTS ----------------------------------------------------------------------------------
--
-- Attributes may be prevented from storing restatements.
-- A restatement is when the same value occurs for two adjacent points
-- in changing time.
--
-- returns 1 for at least one equal surrounding value, 0 for different surrounding values
--
-- id the identity of the anchored entity
-- eq the equivalent (when applicable)
-- value the value of the attribute
-- changed the point in time from which this value shall represent a change
--
-- Restatement Finder Function and Constraint -------------------------------------------------------------------------
-- rfPR_NAME_Product_Name restatement finder, also used by the insert and update triggers for idempotent attributes
-- rcPR_NAME_Product_Name restatement constraint (available only in attributes that cannot have restatements)
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rfPR_NAME_Product_Name(
    int,
    varchar(64),
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rfPR_NAME_Product_Name(
    id int,
    value varchar(64),
    changed timestamp
) RETURNS smallint AS '
    BEGIN
        IF EXISTS (
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        pre.PR_NAME_Product_Name
                    FROM
                        dbo.PR_NAME_Product_Name pre
                    WHERE
                        pre.PR_NAME_PR_ID = id
                    AND
                        pre.PR_NAME_ChangedAt < changed
                    ORDER BY
                        pre.PR_NAME_ChangedAt DESC
                    LIMIT 1
            )
        )
        OR EXISTS(
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        fol.PR_NAME_Product_Name
                    FROM
                        dbo.PR_NAME_Product_Name fol
                    WHERE
                        fol.PR_NAME_PR_ID = id
                    AND
                        fol.PR_NAME_ChangedAt > changed
                    ORDER BY
                        fol.PR_NAME_ChangedAt ASC
                    LIMIT 1
            )
        )
        THEN
            RETURN 1;
        END IF;
        RETURN 0;
    END;
' LANGUAGE plpgsql;
-- KEY GENERATORS -----------------------------------------------------------------------------------------------------
--
-- These stored procedures can be used to generate identities of entities.
-- Corresponding anchors must have an incrementing identity column.
--
-- Key Generation Stored Procedure ------------------------------------------------------------------------------------
-- kPR_Product identity by surrogate key generation stored procedure
-----------------------------------------------------------------------------------------------------------------------
--DROP FUNCTION IF EXISTS dbo.kPR_Product(
-- bigint
--);
CREATE OR REPLACE FUNCTION dbo.kPR_Product(
    requestedNumberOfIdentities bigint
) RETURNS void AS '
    BEGIN
        IF requestedNumberOfIdentities > 0
        THEN
            WITH RECURSIVE idGenerator (idNumber) AS (
                SELECT
                    1
                UNION ALL
                SELECT
                    idNumber + 1
                FROM
                    idGenerator
                WHERE
                    idNumber < requestedNumberOfIdentities
            )
            INSERT INTO dbo.PR_Product (
                PR_Dummy
            )
            SELECT
                null
            FROM
                idGenerator;
        END IF;
    END;
' LANGUAGE plpgsql;
-- ATTRIBUTE REWINDERS ------------------------------------------------------------------------------------------------
--
-- These table valued functions rewind an attribute table to the given
-- point in changing time. It does not pick a temporal perspective and
-- instead shows all rows that have been in effect before that point
-- in time.
--
-- changingTimepoint the point in changing time to rewind to
--
-- Attribute rewinder -------------------------------------------------------------------------------------------------
-- rPR_NAME_Product_Name rewinding over changing time function
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rPR_NAME_Product_Name(
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rPR_NAME_Product_Name(
    changingTimepoint timestamp
) RETURNS TABLE(
    PR_NAME_PR_ID int,
    PR_NAME_Product_Name varchar(64),
    PR_NAME_ChangedAt timestamp
) AS '
    SELECT
        PR_NAME_PR_ID,
        PR_NAME_Product_Name,
        PR_NAME_ChangedAt
    FROM
        dbo.PR_NAME_Product_Name
    WHERE
        PR_NAME_ChangedAt <= changingTimepoint;
' LANGUAGE SQL;
-- ANCHOR TEMPORAL PERSPECTIVES ---------------------------------------------------------------------------------------
--
-- These functions simplify temporal querying by providing a temporal
-- perspective of each anchor. There are four types of perspectives: latest,
-- point-in-time, difference, and now. They also denormalize the anchor, its attributes,
-- and referenced knots from sixth to third normal form.
--
-- The latest perspective shows the latest available information for each anchor.
-- The now perspective shows the information as it is right now.
-- The point-in-time perspective lets you travel through the information to the given timepoint.
--
-- changingTimepoint the point in changing time to travel to
--
-- The difference perspective shows changes between the two given timepoints, and for
-- changes in all or a selection of attributes.
--
-- intervalStart the start of the interval for finding changes
-- intervalEnd the end of the interval for finding changes
-- selection a list of mnemonics for tracked attributes, ie 'MNE MON ICS', or null for all
--
-- Under equivalence all these views default to equivalent = 0, however, corresponding
-- prepended-e perspectives are provided in order to select a specific equivalent.
--
-- equivalent the equivalent for which to retrieve data
--
-- DROP ANCHOR TEMPORAL PERSPECTIVES ----------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.dPR_Product(
    timestamp without time zone, 
    timestamp without time zone, 
    text
);
DROP VIEW IF EXISTS dbo.nPR_Product;
DROP FUNCTION IF EXISTS dbo.pPR_Product(
    timestamp without time zone
);
DROP VIEW IF EXISTS dbo.lPR_Product;
*/
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lPR_Product viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.lPR_Product AS
SELECT
    PR.PR_ID,
    NAME.PR_NAME_PR_ID,
    NAME.PR_NAME_ChangedAt,
    NAME.PR_NAME_Product_Name,
    ID.PR_ID_PR_ID,
    ID.PR_ID_Product_Uuid
FROM
    dbo.PR_Product PR
LEFT JOIN
    dbo.PR_NAME_Product_Name NAME
ON
    NAME.PR_NAME_PR_ID = PR.PR_ID
AND
    NAME.PR_NAME_ChangedAt = (
        SELECT
            max(sub.PR_NAME_ChangedAt)
        FROM
            dbo.PR_NAME_Product_Name sub
        WHERE
            sub.PR_NAME_PR_ID = PR.PR_ID
   )
LEFT JOIN
    dbo.PR_ID_Product_Uuid ID
ON
    ID.PR_ID_PR_ID = PR.PR_ID;
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- pPR_Product viewed as it was on the given timepoint
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION dbo.pPR_Product (
    changingTimepoint timestamp without time zone
)
RETURNS TABLE (
    PR_ID int,
    PR_NAME_PR_ID int,
    PR_NAME_ChangedAt timestamp,
    PR_NAME_Product_Name varchar(64),
    PR_ID_PR_ID int,
    PR_ID_Product_Uuid uuid
) AS '
SELECT
    PR.PR_ID,
    NAME.PR_NAME_PR_ID,
    NAME.PR_NAME_ChangedAt,
    NAME.PR_NAME_Product_Name,
    ID.PR_ID_PR_ID,
    ID.PR_ID_Product_Uuid
FROM
    dbo.PR_Product PR
LEFT JOIN
    dbo.rPR_NAME_Product_Name(CAST(changingTimepoint AS timestamp)) NAME
ON
    NAME.PR_NAME_PR_ID = PR.PR_ID
AND
    NAME.PR_NAME_ChangedAt = (
        SELECT
            max(sub.PR_NAME_ChangedAt)
        FROM
            dbo.rPR_NAME_Product_Name(CAST(changingTimepoint AS timestamp)) sub
        WHERE
            sub.PR_NAME_PR_ID = PR.PR_ID
   )
LEFT JOIN
    dbo.PR_ID_Product_Uuid ID
ON
    ID.PR_ID_PR_ID = PR.PR_ID;
' LANGUAGE SQL;
-- Now perspective ----------------------------------------------------------------------------------------------------
-- nPR_Product viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.nPR_Product AS
SELECT
    *
FROM
    dbo.pPR_Product(LOCALTIMESTAMP);
-- Difference perspective ---------------------------------------------------------------------------------------------
-- dPR_Product showing all differences between the given timepoints and optionally for a subset of attributes
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION dbo.dPR_Product (
    intervalStart timestamp without time zone,
    intervalEnd timestamp without time zone,
    selection text = null
) RETURNS TABLE (
    inspectedTimepoint timestamp without time zone,
    mnemonic text,
    PR_ID int,
    PR_NAME_PR_ID int,
    PR_NAME_ChangedAt timestamp,
    PR_NAME_Product_Name varchar(64),
    PR_ID_PR_ID int,
    PR_ID_Product_Uuid uuid
) AS '
SELECT
    timepoints.inspectedTimepoint,
    timepoints.mnemonic,
    pPR.*
FROM (
    SELECT DISTINCT
        PR_NAME_PR_ID AS PR_ID,
        CAST(PR_NAME_ChangedAt AS timestamp without time zone) AS inspectedTimepoint,
        ''NAME'' AS mnemonic
    FROM
        dbo.PR_NAME_Product_Name
    WHERE
        (selection is null OR selection like ''%NAME%'')
    AND
        PR_NAME_ChangedAt BETWEEN intervalStart AND intervalEnd
) timepoints
CROSS JOIN LATERAL
    dbo.pPR_Product(timepoints.inspectedTimepoint) pPR
WHERE
    pPR.PR_ID = timepoints.PR_ID;
' LANGUAGE SQL;
-- ATTRIBUTE TRIGGERS -------------------------------------------------------------------------------------------------
--
-- The following triggers on the attributes make them behave like tables.
-- They will ensure that such operations are propagated to the underlying tables
-- in a consistent way. Default values are used for some columns if not provided
-- by the corresponding SQL statements.
--
-- For idempotent attributes, only changes that represent a value different from
-- the previous or following value are stored. Others are silently ignored in
-- order to avoid unnecessary temporal duplicates.
--
-- BEFORE INSERT trigger ----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcbPR_NAME_Product_Name ON dbo.PR_NAME_Product_Name;
DROP FUNCTION IF EXISTS dbo.tcbPR_NAME_Product_Name();
CREATE OR REPLACE FUNCTION dbo.tcbPR_NAME_Product_Name() RETURNS trigger AS '
    BEGIN
        -- temporary table is used to create an insert order 
        -- (so that rows are inserted in order with respect to temporality)
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_PR_NAME_Product_Name (
            PR_NAME_PR_ID int not null,
            PR_NAME_ChangedAt timestamp not null,
            PR_NAME_Product_Name varchar(64) not null,
            PR_NAME_Version bigint not null,
            PR_NAME_StatementType char(1) not null,
            primary key(
                PR_NAME_Version,
                PR_NAME_PR_ID
            )
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcbPR_NAME_Product_Name
BEFORE INSERT ON dbo.PR_NAME_Product_Name
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcbPR_NAME_Product_Name();
-- INSTEAD OF INSERT trigger ------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tciPR_NAME_Product_Name ON dbo.PR_NAME_Product_Name;
DROP FUNCTION IF EXISTS dbo.tciPR_NAME_Product_Name();
CREATE OR REPLACE FUNCTION dbo.tciPR_NAME_Product_Name() RETURNS trigger AS '
    BEGIN
        -- insert rows into the temporary table
        INSERT INTO _tmp_PR_NAME_Product_Name
        SELECT
            NEW.PR_NAME_PR_ID,
            NEW.PR_NAME_ChangedAt,
            NEW.PR_NAME_Product_Name,
            0,
            ''X'';
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tciPR_NAME_Product_Name
INSTEAD OF INSERT ON dbo.PR_NAME_Product_Name
FOR EACH ROW
EXECUTE PROCEDURE dbo.tciPR_NAME_Product_Name();
-- AFTER INSERT trigger -----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcaPR_NAME_Product_Name ON dbo.PR_NAME_Product_Name;
DROP FUNCTION IF EXISTS dbo.tcaPR_NAME_Product_Name();
CREATE OR REPLACE FUNCTION dbo.tcaPR_NAME_Product_Name() RETURNS trigger AS '
    DECLARE maxVersion int;
    DECLARE currentVersion int = 0;
BEGIN
    -- find ranks for inserted data (using self join)
    UPDATE _tmp_PR_NAME_Product_Name
    SET PR_NAME_Version = v.rank
    FROM (
        SELECT
            DENSE_RANK() OVER (
                PARTITION BY
                    PR_NAME_PR_ID
                ORDER BY
                    PR_NAME_ChangedAt ASC
            ) AS rank,
            PR_NAME_PR_ID AS pk
        FROM _tmp_PR_NAME_Product_Name
    ) AS v
    WHERE PR_NAME_PR_ID = v.pk
    AND PR_NAME_Version = 0;
    -- find max version
    SELECT
        MAX(PR_NAME_Version) INTO maxVersion
    FROM
        _tmp_PR_NAME_Product_Name;
    -- is max version NULL?
    IF (maxVersion is null) THEN
        RETURN NULL;
    END IF;
    -- loop over versions
    LOOP
        currentVersion := currentVersion + 1;
        -- set statement types
        UPDATE _tmp_PR_NAME_Product_Name
        SET
            PR_NAME_StatementType =
                CASE
                    WHEN NAME.PR_NAME_PR_ID is not null
                    THEN ''D'' -- duplicate
                    WHEN dbo.rfPR_NAME_Product_Name(
                        v.PR_NAME_PR_ID,
                        v.PR_NAME_Product_Name,
                        v.PR_NAME_ChangedAt
                    ) = 1
                    THEN ''R'' -- restatement
                    ELSE ''N'' -- new statement
                END
        FROM
            _tmp_PR_NAME_Product_Name v
        LEFT JOIN
            dbo._PR_NAME_Product_Name NAME
        ON
            NAME.PR_NAME_PR_ID = v.PR_NAME_PR_ID
        AND
            NAME.PR_NAME_ChangedAt = v.PR_NAME_ChangedAt
        AND
            NAME.PR_NAME_Product_Name = v.PR_NAME_Product_Name
        WHERE
            v.PR_NAME_Version = currentVersion;
        -- insert data into attribute table
        INSERT INTO dbo._PR_NAME_Product_Name (
            PR_NAME_PR_ID,
            PR_NAME_ChangedAt,
            PR_NAME_Product_Name
        )
        SELECT
            PR_NAME_PR_ID,
            PR_NAME_ChangedAt,
            PR_NAME_Product_Name
        FROM
            _tmp_PR_NAME_Product_Name
        WHERE
            PR_NAME_Version = currentVersion
        AND
            PR_NAME_StatementType in (''N'');
        EXIT WHEN currentVersion >= maxVersion;
    END LOOP;
    DROP TABLE IF EXISTS _tmp_PR_NAME_Product_Name;
    RETURN NULL;
END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcaPR_NAME_Product_Name
AFTER INSERT ON dbo.PR_NAME_Product_Name
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcaPR_NAME_Product_Name();
-- BEFORE INSERT trigger ----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcbPR_ID_Product_Uuid ON dbo.PR_ID_Product_Uuid;
DROP FUNCTION IF EXISTS dbo.tcbPR_ID_Product_Uuid();
CREATE OR REPLACE FUNCTION dbo.tcbPR_ID_Product_Uuid() RETURNS trigger AS '
    BEGIN
        -- temporary table is used to create an insert order 
        -- (so that rows are inserted in order with respect to temporality)
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_PR_ID_Product_Uuid (
            PR_ID_PR_ID int not null,
            PR_ID_Product_Uuid uuid not null,
            PR_ID_Version bigint not null,
            PR_ID_StatementType char(1) not null,
            primary key(
                PR_ID_Version,
                PR_ID_PR_ID
            )
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcbPR_ID_Product_Uuid
BEFORE INSERT ON dbo.PR_ID_Product_Uuid
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcbPR_ID_Product_Uuid();
-- INSTEAD OF INSERT trigger ------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tciPR_ID_Product_Uuid ON dbo.PR_ID_Product_Uuid;
 DROP FUNCTION IF EXISTS dbo.tciPR_ID_Product_Uuid();
CREATE OR REPLACE FUNCTION dbo.tciPR_ID_Product_Uuid() RETURNS trigger AS '
    BEGIN
        -- insert rows into the temporary table
        INSERT INTO _tmp_PR_ID_Product_Uuid
        SELECT
            NEW.PR_ID_PR_ID,
            NEW.PR_ID_Product_Uuid,
            1,
            ''X'';
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tciPR_ID_Product_Uuid
INSTEAD OF INSERT ON dbo.PR_ID_Product_Uuid
FOR EACH ROW
EXECUTE PROCEDURE dbo.tciPR_ID_Product_Uuid();
-- AFTER INSERT trigger -----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcaPR_ID_Product_Uuid ON dbo.PR_ID_Product_Uuid;
DROP FUNCTION IF EXISTS dbo.tcaPR_ID_Product_Uuid();
CREATE OR REPLACE FUNCTION dbo.tcaPR_ID_Product_Uuid() RETURNS trigger AS '
    DECLARE maxVersion int;
    DECLARE currentVersion int = 0;
BEGIN
    -- find max version
    SELECT
        MAX(PR_ID_Version) INTO maxVersion
    FROM
        _tmp_PR_ID_Product_Uuid;
    -- is max version NULL?
    IF (maxVersion is null) THEN
        RETURN NULL;
    END IF;
    -- loop over versions
    LOOP
        currentVersion := currentVersion + 1;
        -- set statement types
        UPDATE _tmp_PR_ID_Product_Uuid
        SET
            PR_ID_StatementType =
                CASE
                    WHEN ID.PR_ID_PR_ID is not null
                    THEN ''D'' -- duplicate
                    ELSE ''N'' -- new statement
                END
        FROM
            _tmp_PR_ID_Product_Uuid v
        LEFT JOIN
            dbo._PR_ID_Product_Uuid ID
        ON
            ID.PR_ID_PR_ID = v.PR_ID_PR_ID
        AND
            ID.PR_ID_Product_Uuid = v.PR_ID_Product_Uuid
        WHERE
            v.PR_ID_Version = currentVersion;
        -- insert data into attribute table
        INSERT INTO dbo._PR_ID_Product_Uuid (
            PR_ID_PR_ID,
            PR_ID_Product_Uuid
        )
        SELECT
            PR_ID_PR_ID,
            PR_ID_Product_Uuid
        FROM
            _tmp_PR_ID_Product_Uuid
        WHERE
            PR_ID_Version = currentVersion
        AND
            PR_ID_StatementType in (''N'');
        EXIT WHEN currentVersion >= maxVersion;
    END LOOP;
    DROP TABLE IF EXISTS _tmp_PR_ID_Product_Uuid;
    RETURN NULL;
END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcaPR_ID_Product_Uuid
AFTER INSERT ON dbo.PR_ID_Product_Uuid
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcaPR_ID_Product_Uuid();
-- ANCHOR TRIGGERS ---------------------------------------------------------------------------------------------------
--
-- The following triggers on the latest view make it behave like a table.
-- There are three different 'instead of' triggers: insert, update, and delete.
-- They will ensure that such operations are propagated to the underlying tables
-- in a consistent way. Default values are used for some columns if not provided
-- by the corresponding SQL statements.
--
-- For idempotent attributes, only changes that represent a value different from
-- the previous or following value are stored. Others are silently ignored in
-- order to avoid unnecessary temporal duplicates.
--
-- BEFORE INSERT trigger --------------------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS itb_lPR_Product ON dbo.lPR_Product;
DROP FUNCTION IF EXISTS dbo.itb_lPR_Product();
CREATE OR REPLACE FUNCTION dbo.itb_lPR_Product() RETURNS trigger AS '
    BEGIN
        -- create temporary table to keep inserted rows in
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_it_PR_Product (
            PR_ID int not null,
            PR_NAME_PR_ID int null,
            PR_NAME_ChangedAt timestamp null,
            PR_NAME_Product_Name varchar(64) null,
            PR_ID_PR_ID int null,
            PR_ID_Product_Uuid uuid null
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER itb_lPR_Product
BEFORE INSERT ON dbo.lPR_Product
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.itb_lPR_Product(); 
-- INSTEAD OF INSERT trigger ----------------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS iti_lPR_Product ON dbo.lPR_Product;
DROP FUNCTION IF EXISTS dbo.iti_lPR_Product();
CREATE OR REPLACE FUNCTION dbo.iti_lPR_Product() RETURNS trigger AS '
    BEGIN
        -- generate anchor ID (if not provided)
        IF (NEW.PR_ID IS NULL) THEN 
            INSERT INTO dbo.PR_Product (
                PR_Dummy
            ) VALUES (
                null
            );
            SELECT
                lastval() 
            INTO NEW.PR_ID;
        -- if anchor ID is provided then let''s insert it into the anchor table
        -- but only if that ID is not present in the anchor table
        ELSE
            INSERT INTO dbo.PR_Product (
                PR_ID
            )
            SELECT
                NEW.PR_ID
            WHERE NOT EXISTS(
	            SELECT
	                PR_ID 
	            FROM dbo.PR_Product
	            WHERE PR_ID = NEW.PR_ID
	            LIMIT 1
            );
        END IF;
        -- insert row into temporary table
    	INSERT INTO _tmp_it_PR_Product (
            PR_ID,
            PR_NAME_PR_ID,
            PR_NAME_ChangedAt,
            PR_NAME_Product_Name,
            PR_ID_PR_ID,
            PR_ID_Product_Uuid
    	) VALUES (
    	    NEW.PR_ID,
            COALESCE(NEW.PR_NAME_PR_ID, NEW.PR_ID),
            COALESCE(NEW.PR_NAME_ChangedAt, CAST(LOCALTIMESTAMP AS timestamp)),
            NEW.PR_NAME_Product_Name,
            COALESCE(NEW.PR_ID_PR_ID, NEW.PR_ID),
            NEW.PR_ID_Product_Uuid
    	);
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER iti_lPR_Product
INSTEAD OF INSERT ON dbo.lPR_Product
FOR EACH ROW
EXECUTE PROCEDURE dbo.iti_lPR_Product();
-- AFTER INSERT trigger ---------------------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS ita_lPR_Product ON dbo.lPR_Product;
DROP FUNCTION IF EXISTS dbo.ita_lPR_Product();
CREATE OR REPLACE FUNCTION dbo.ita_lPR_Product() RETURNS trigger AS '
    BEGIN
        INSERT INTO dbo.PR_NAME_Product_Name (
            PR_NAME_PR_ID,
            PR_NAME_ChangedAt,
            PR_NAME_Product_Name
        )
        SELECT
            i.PR_NAME_PR_ID,
            i.PR_NAME_ChangedAt,
            i.PR_NAME_Product_Name
        FROM
            _tmp_it_PR_Product i
        WHERE
            i.PR_NAME_Product_Name is not null;
        INSERT INTO dbo.PR_ID_Product_Uuid (
            PR_ID_PR_ID,
            PR_ID_Product_Uuid
        )
        SELECT
            i.PR_ID_PR_ID,
            i.PR_ID_Product_Uuid
        FROM
            _tmp_it_PR_Product i
        WHERE
            i.PR_ID_Product_Uuid is not null;
        DROP TABLE IF EXISTS _tmp_it_PR_Product;
        RETURN NULL;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER ita_lPR_Product
AFTER INSERT ON dbo.lPR_Product
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.ita_lPR_Product();
-- TIE TEMPORAL PERSPECTIVES ------------------------------------------------------------------------------------------
--
-- These table valued functions simplify temporal querying by providing a temporal
-- perspective of each tie. There are four types of perspectives: latest,
-- point-in-time, difference, and now.
--
-- The latest perspective shows the latest available information for each tie.
-- The now perspective shows the information as it is right now.
-- The point-in-time perspective lets you travel through the information to the given timepoint.
--
-- changingTimepoint the point in changing time to travel to
--
-- The difference perspective shows changes between the two given timepoints.
--
-- intervalStart the start of the interval for finding changes
-- intervalEnd the end of the interval for finding changes
--
-- Under equivalence all these views default to equivalent = 0, however, corresponding
-- prepended-e perspectives are provided in order to select a specific equivalent.
--
-- equivalent the equivalent for which to retrieve data
--
-- DROP TIE TEMPORAL PERSPECTIVES ----------------------------------------------------------------------------------
/*
*/
-- DESCRIPTIONS -------------------------------------------------------------------------------------------------------