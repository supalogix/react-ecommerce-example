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
-- PR_Product table (with 4 attributes)
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
-- PR_DSC_Product_Description table (on PR_Product)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._PR_DSC_Product_Description;
CREATE TABLE IF NOT EXISTS dbo._PR_DSC_Product_Description (
    PR_DSC_PR_ID int not null,
    PR_DSC_Product_Description varchar(256) not null,
    PR_DSC_ChangedAt timestamp not null,
    constraint fkPR_DSC_Product_Description foreign key (
        PR_DSC_PR_ID
    ) references dbo._PR_Product(PR_ID),
    constraint pkPR_DSC_Product_Description primary key (
        PR_DSC_PR_ID,
        PR_DSC_ChangedAt
    )
);
ALTER TABLE IF EXISTS ONLY dbo._PR_DSC_Product_Description CLUSTER ON pkPR_DSC_Product_Description;
-- DROP VIEW IF EXISTS dbo.PR_DSC_Product_Description;
CREATE OR REPLACE VIEW dbo.PR_DSC_Product_Description AS SELECT
    PR_DSC_PR_ID,
    PR_DSC_Product_Description,
    PR_DSC_ChangedAt
FROM dbo._PR_DSC_Product_Description;
-- Historized attribute table -----------------------------------------------------------------------------------------
-- PR_NAM_Product_Name table (on PR_Product)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._PR_NAM_Product_Name;
CREATE TABLE IF NOT EXISTS dbo._PR_NAM_Product_Name (
    PR_NAM_PR_ID int not null,
    PR_NAM_Product_Name varchar(256) not null,
    PR_NAM_ChangedAt timestamp not null,
    constraint fkPR_NAM_Product_Name foreign key (
        PR_NAM_PR_ID
    ) references dbo._PR_Product(PR_ID),
    constraint pkPR_NAM_Product_Name primary key (
        PR_NAM_PR_ID,
        PR_NAM_ChangedAt
    )
);
ALTER TABLE IF EXISTS ONLY dbo._PR_NAM_Product_Name CLUSTER ON pkPR_NAM_Product_Name;
-- DROP VIEW IF EXISTS dbo.PR_NAM_Product_Name;
CREATE OR REPLACE VIEW dbo.PR_NAM_Product_Name AS SELECT
    PR_NAM_PR_ID,
    PR_NAM_Product_Name,
    PR_NAM_ChangedAt
FROM dbo._PR_NAM_Product_Name;
-- Static attribute table ---------------------------------------------------------------------------------------------
-- PR_UID_Product_UUID table (on PR_Product)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._PR_UID_Product_UUID;
CREATE TABLE IF NOT EXISTS dbo._PR_UID_Product_UUID (
    PR_UID_PR_ID int not null,
    PR_UID_Product_UUID varchar(256) not null,
    constraint fkPR_UID_Product_UUID foreign key (
        PR_UID_PR_ID
    ) references dbo._PR_Product(PR_ID),
    constraint pkPR_UID_Product_UUID primary key (
        PR_UID_PR_ID
    )
);
ALTER TABLE IF EXISTS ONLY dbo._PR_UID_Product_UUID CLUSTER ON pkPR_UID_Product_UUID;
-- DROP VIEW IF EXISTS dbo.PR_UID_Product_UUID;
CREATE OR REPLACE VIEW dbo.PR_UID_Product_UUID AS SELECT
    PR_UID_PR_ID,
    PR_UID_Product_UUID
FROM dbo._PR_UID_Product_UUID;
-- Historized attribute table -----------------------------------------------------------------------------------------
-- PR_REP_Product_RetailPrice table (on PR_Product)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._PR_REP_Product_RetailPrice;
CREATE TABLE IF NOT EXISTS dbo._PR_REP_Product_RetailPrice (
    PR_REP_PR_ID int not null,
    PR_REP_Product_RetailPrice int not null,
    PR_REP_ChangedAt timestamp not null,
    constraint fkPR_REP_Product_RetailPrice foreign key (
        PR_REP_PR_ID
    ) references dbo._PR_Product(PR_ID),
    constraint pkPR_REP_Product_RetailPrice primary key (
        PR_REP_PR_ID,
        PR_REP_ChangedAt
    )
);
ALTER TABLE IF EXISTS ONLY dbo._PR_REP_Product_RetailPrice CLUSTER ON pkPR_REP_Product_RetailPrice;
-- DROP VIEW IF EXISTS dbo.PR_REP_Product_RetailPrice;
CREATE OR REPLACE VIEW dbo.PR_REP_Product_RetailPrice AS SELECT
    PR_REP_PR_ID,
    PR_REP_Product_RetailPrice,
    PR_REP_ChangedAt
FROM dbo._PR_REP_Product_RetailPrice;
-- Anchor table -------------------------------------------------------------------------------------------------------
-- AC_Account table (with 2 attributes)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._AC_Account;
CREATE TABLE IF NOT EXISTS dbo._AC_Account (
    AC_ID serial not null, 
    AC_Dummy boolean null,
    constraint pkAC_Account primary key (
        AC_ID
    )
);
ALTER TABLE IF EXISTS ONLY dbo._AC_Account CLUSTER ON pkAC_Account;
-- DROP VIEW IF EXISTS dbo.AC_Account;
CREATE OR REPLACE VIEW dbo.AC_Account AS SELECT 
    AC_ID,
    AC_Dummy
FROM dbo._AC_Account;
-- Static attribute table ---------------------------------------------------------------------------------------------
-- AC_NAM_Account_Username table (on AC_Account)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._AC_NAM_Account_Username;
CREATE TABLE IF NOT EXISTS dbo._AC_NAM_Account_Username (
    AC_NAM_AC_ID int not null,
    AC_NAM_Account_Username varchar(256) not null,
    constraint fkAC_NAM_Account_Username foreign key (
        AC_NAM_AC_ID
    ) references dbo._AC_Account(AC_ID),
    constraint pkAC_NAM_Account_Username primary key (
        AC_NAM_AC_ID
    )
);
ALTER TABLE IF EXISTS ONLY dbo._AC_NAM_Account_Username CLUSTER ON pkAC_NAM_Account_Username;
-- DROP VIEW IF EXISTS dbo.AC_NAM_Account_Username;
CREATE OR REPLACE VIEW dbo.AC_NAM_Account_Username AS SELECT
    AC_NAM_AC_ID,
    AC_NAM_Account_Username
FROM dbo._AC_NAM_Account_Username;
-- Historized attribute table -----------------------------------------------------------------------------------------
-- AC_PAS_Account_Password table (on AC_Account)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._AC_PAS_Account_Password;
CREATE TABLE IF NOT EXISTS dbo._AC_PAS_Account_Password (
    AC_PAS_AC_ID int not null,
    AC_PAS_Account_Password varchar(256) not null,
    AC_PAS_ChangedAt timestamp not null,
    constraint fkAC_PAS_Account_Password foreign key (
        AC_PAS_AC_ID
    ) references dbo._AC_Account(AC_ID),
    constraint pkAC_PAS_Account_Password primary key (
        AC_PAS_AC_ID,
        AC_PAS_ChangedAt
    )
);
ALTER TABLE IF EXISTS ONLY dbo._AC_PAS_Account_Password CLUSTER ON pkAC_PAS_Account_Password;
-- DROP VIEW IF EXISTS dbo.AC_PAS_Account_Password;
CREATE OR REPLACE VIEW dbo.AC_PAS_Account_Password AS SELECT
    AC_PAS_AC_ID,
    AC_PAS_Account_Password,
    AC_PAS_ChangedAt
FROM dbo._AC_PAS_Account_Password;
-- Anchor table -------------------------------------------------------------------------------------------------------
-- TK_Token table (with 0 attributes)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._TK_Token;
CREATE TABLE IF NOT EXISTS dbo._TK_Token (
    TK_ID serial not null, 
    TK_Dummy boolean null,
    constraint pkTK_Token primary key (
        TK_ID
    )
);
ALTER TABLE IF EXISTS ONLY dbo._TK_Token CLUSTER ON pkTK_Token;
-- DROP VIEW IF EXISTS dbo.TK_Token;
CREATE OR REPLACE VIEW dbo.TK_Token AS SELECT 
    TK_ID,
    TK_Dummy
FROM dbo._TK_Token;
-- TIES ---------------------------------------------------------------------------------------------------------------
--
-- Ties are used to represent relationships between entities.
-- They come in four flavors: static, historized, knotted static, and knotted historized.
-- Ties have cardinality, constraining how members may participate in the relationship.
-- Every entity that is a member in a tie has a specified role in the relationship.
-- Ties must have at least two anchor roles and zero or more knot roles.
--
-- Static tie table ---------------------------------------------------------------------------------------------------
-- AC_has_TK_belongsTo table (having 2 roles)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._AC_has_TK_belongsTo;
CREATE TABLE IF NOT EXISTS dbo._AC_has_TK_belongsTo (
    AC_ID_has int not null, 
    TK_ID_belongsTo int not null, 
    constraint AC_has_TK_belongsTo_fkAC_has foreign key (
        AC_ID_has
    ) references dbo._AC_Account(AC_ID), 
    constraint AC_has_TK_belongsTo_fkTK_belongsTo foreign key (
        TK_ID_belongsTo
    ) references dbo._TK_Token(TK_ID), 
    constraint pkAC_has_TK_belongsTo primary key (
        AC_ID_has,
        TK_ID_belongsTo
    )
);
ALTER TABLE IF EXISTS ONLY dbo._AC_has_TK_belongsTo CLUSTER ON pkAC_has_TK_belongsTo;
-- DROP VIEW IF EXISTS dbo.AC_has_TK_belongsTo;
CREATE OR REPLACE VIEW dbo.AC_has_TK_belongsTo AS SELECT
    AC_ID_has,
    TK_ID_belongsTo
FROM dbo._AC_has_TK_belongsTo;
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
-- rfPR_DSC_Product_Description restatement finder, also used by the insert and update triggers for idempotent attributes
-- rcPR_DSC_Product_Description restatement constraint (available only in attributes that cannot have restatements)
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rfPR_DSC_Product_Description(
    int,
    varchar(256),
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rfPR_DSC_Product_Description(
    id int,
    value varchar(256),
    changed timestamp
) RETURNS smallint AS '
    BEGIN
        IF EXISTS (
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        pre.PR_DSC_Product_Description
                    FROM
                        dbo.PR_DSC_Product_Description pre
                    WHERE
                        pre.PR_DSC_PR_ID = id
                    AND
                        pre.PR_DSC_ChangedAt < changed
                    ORDER BY
                        pre.PR_DSC_ChangedAt DESC
                    LIMIT 1
            )
        )
        OR EXISTS(
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        fol.PR_DSC_Product_Description
                    FROM
                        dbo.PR_DSC_Product_Description fol
                    WHERE
                        fol.PR_DSC_PR_ID = id
                    AND
                        fol.PR_DSC_ChangedAt > changed
                    ORDER BY
                        fol.PR_DSC_ChangedAt ASC
                    LIMIT 1
            )
        )
        THEN
            RETURN 1;
        END IF;
        RETURN 0;
    END;
' LANGUAGE plpgsql;
-- Restatement Finder Function and Constraint -------------------------------------------------------------------------
-- rfPR_NAM_Product_Name restatement finder, also used by the insert and update triggers for idempotent attributes
-- rcPR_NAM_Product_Name restatement constraint (available only in attributes that cannot have restatements)
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rfPR_NAM_Product_Name(
    int,
    varchar(256),
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rfPR_NAM_Product_Name(
    id int,
    value varchar(256),
    changed timestamp
) RETURNS smallint AS '
    BEGIN
        IF EXISTS (
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        pre.PR_NAM_Product_Name
                    FROM
                        dbo.PR_NAM_Product_Name pre
                    WHERE
                        pre.PR_NAM_PR_ID = id
                    AND
                        pre.PR_NAM_ChangedAt < changed
                    ORDER BY
                        pre.PR_NAM_ChangedAt DESC
                    LIMIT 1
            )
        )
        OR EXISTS(
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        fol.PR_NAM_Product_Name
                    FROM
                        dbo.PR_NAM_Product_Name fol
                    WHERE
                        fol.PR_NAM_PR_ID = id
                    AND
                        fol.PR_NAM_ChangedAt > changed
                    ORDER BY
                        fol.PR_NAM_ChangedAt ASC
                    LIMIT 1
            )
        )
        THEN
            RETURN 1;
        END IF;
        RETURN 0;
    END;
' LANGUAGE plpgsql;
-- Restatement Finder Function and Constraint -------------------------------------------------------------------------
-- rfPR_REP_Product_RetailPrice restatement finder, also used by the insert and update triggers for idempotent attributes
-- rcPR_REP_Product_RetailPrice restatement constraint (available only in attributes that cannot have restatements)
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rfPR_REP_Product_RetailPrice(
    int,
    int,
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rfPR_REP_Product_RetailPrice(
    id int,
    value int,
    changed timestamp
) RETURNS smallint AS '
    BEGIN
        IF EXISTS (
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        pre.PR_REP_Product_RetailPrice
                    FROM
                        dbo.PR_REP_Product_RetailPrice pre
                    WHERE
                        pre.PR_REP_PR_ID = id
                    AND
                        pre.PR_REP_ChangedAt < changed
                    ORDER BY
                        pre.PR_REP_ChangedAt DESC
                    LIMIT 1
            )
        )
        OR EXISTS(
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        fol.PR_REP_Product_RetailPrice
                    FROM
                        dbo.PR_REP_Product_RetailPrice fol
                    WHERE
                        fol.PR_REP_PR_ID = id
                    AND
                        fol.PR_REP_ChangedAt > changed
                    ORDER BY
                        fol.PR_REP_ChangedAt ASC
                    LIMIT 1
            )
        )
        THEN
            RETURN 1;
        END IF;
        RETURN 0;
    END;
' LANGUAGE plpgsql;
-- Restatement Finder Function and Constraint -------------------------------------------------------------------------
-- rfAC_PAS_Account_Password restatement finder, also used by the insert and update triggers for idempotent attributes
-- rcAC_PAS_Account_Password restatement constraint (available only in attributes that cannot have restatements)
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rfAC_PAS_Account_Password(
    int,
    varchar(256),
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rfAC_PAS_Account_Password(
    id int,
    value varchar(256),
    changed timestamp
) RETURNS smallint AS '
    BEGIN
        IF EXISTS (
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        pre.AC_PAS_Account_Password
                    FROM
                        dbo.AC_PAS_Account_Password pre
                    WHERE
                        pre.AC_PAS_AC_ID = id
                    AND
                        pre.AC_PAS_ChangedAt < changed
                    ORDER BY
                        pre.AC_PAS_ChangedAt DESC
                    LIMIT 1
            )
        )
        OR EXISTS(
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        fol.AC_PAS_Account_Password
                    FROM
                        dbo.AC_PAS_Account_Password fol
                    WHERE
                        fol.AC_PAS_AC_ID = id
                    AND
                        fol.AC_PAS_ChangedAt > changed
                    ORDER BY
                        fol.AC_PAS_ChangedAt ASC
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
-- Key Generation Stored Procedure ------------------------------------------------------------------------------------
-- kAC_Account identity by surrogate key generation stored procedure
-----------------------------------------------------------------------------------------------------------------------
--DROP FUNCTION IF EXISTS dbo.kAC_Account(
-- bigint
--);
CREATE OR REPLACE FUNCTION dbo.kAC_Account(
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
            INSERT INTO dbo.AC_Account (
                AC_Dummy
            )
            SELECT
                null
            FROM
                idGenerator;
        END IF;
    END;
' LANGUAGE plpgsql;
-- Key Generation Stored Procedure ------------------------------------------------------------------------------------
-- kTK_Token identity by surrogate key generation stored procedure
-----------------------------------------------------------------------------------------------------------------------
--DROP FUNCTION IF EXISTS dbo.kTK_Token(
-- bigint
--);
CREATE OR REPLACE FUNCTION dbo.kTK_Token(
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
            INSERT INTO dbo.TK_Token (
                TK_Dummy
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
-- rPR_DSC_Product_Description rewinding over changing time function
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rPR_DSC_Product_Description(
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rPR_DSC_Product_Description(
    changingTimepoint timestamp
) RETURNS TABLE(
    PR_DSC_PR_ID int,
    PR_DSC_Product_Description varchar(256),
    PR_DSC_ChangedAt timestamp
) AS '
    SELECT
        PR_DSC_PR_ID,
        PR_DSC_Product_Description,
        PR_DSC_ChangedAt
    FROM
        dbo.PR_DSC_Product_Description
    WHERE
        PR_DSC_ChangedAt <= changingTimepoint;
' LANGUAGE SQL;
-- Attribute rewinder -------------------------------------------------------------------------------------------------
-- rPR_NAM_Product_Name rewinding over changing time function
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rPR_NAM_Product_Name(
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rPR_NAM_Product_Name(
    changingTimepoint timestamp
) RETURNS TABLE(
    PR_NAM_PR_ID int,
    PR_NAM_Product_Name varchar(256),
    PR_NAM_ChangedAt timestamp
) AS '
    SELECT
        PR_NAM_PR_ID,
        PR_NAM_Product_Name,
        PR_NAM_ChangedAt
    FROM
        dbo.PR_NAM_Product_Name
    WHERE
        PR_NAM_ChangedAt <= changingTimepoint;
' LANGUAGE SQL;
-- Attribute rewinder -------------------------------------------------------------------------------------------------
-- rPR_REP_Product_RetailPrice rewinding over changing time function
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rPR_REP_Product_RetailPrice(
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rPR_REP_Product_RetailPrice(
    changingTimepoint timestamp
) RETURNS TABLE(
    PR_REP_PR_ID int,
    PR_REP_Product_RetailPrice int,
    PR_REP_ChangedAt timestamp
) AS '
    SELECT
        PR_REP_PR_ID,
        PR_REP_Product_RetailPrice,
        PR_REP_ChangedAt
    FROM
        dbo.PR_REP_Product_RetailPrice
    WHERE
        PR_REP_ChangedAt <= changingTimepoint;
' LANGUAGE SQL;
-- Attribute rewinder -------------------------------------------------------------------------------------------------
-- rAC_PAS_Account_Password rewinding over changing time function
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rAC_PAS_Account_Password(
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rAC_PAS_Account_Password(
    changingTimepoint timestamp
) RETURNS TABLE(
    AC_PAS_AC_ID int,
    AC_PAS_Account_Password varchar(256),
    AC_PAS_ChangedAt timestamp
) AS '
    SELECT
        AC_PAS_AC_ID,
        AC_PAS_Account_Password,
        AC_PAS_ChangedAt
    FROM
        dbo.AC_PAS_Account_Password
    WHERE
        AC_PAS_ChangedAt <= changingTimepoint;
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
DROP FUNCTION IF EXISTS dbo.dAC_Account(
    timestamp without time zone, 
    timestamp without time zone, 
    text
);
DROP VIEW IF EXISTS dbo.nAC_Account;
DROP FUNCTION IF EXISTS dbo.pAC_Account(
    timestamp without time zone
);
DROP VIEW IF EXISTS dbo.lAC_Account;
*/
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lPR_Product viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.lPR_Product AS
SELECT
    PR.PR_ID,
    DSC.PR_DSC_PR_ID,
    DSC.PR_DSC_ChangedAt,
    DSC.PR_DSC_Product_Description,
    NAM.PR_NAM_PR_ID,
    NAM.PR_NAM_ChangedAt,
    NAM.PR_NAM_Product_Name,
    UID.PR_UID_PR_ID,
    UID.PR_UID_Product_UUID,
    REP.PR_REP_PR_ID,
    REP.PR_REP_ChangedAt,
    REP.PR_REP_Product_RetailPrice
FROM
    dbo.PR_Product PR
LEFT JOIN
    dbo.PR_DSC_Product_Description DSC
ON
    DSC.PR_DSC_PR_ID = PR.PR_ID
AND
    DSC.PR_DSC_ChangedAt = (
        SELECT
            max(sub.PR_DSC_ChangedAt)
        FROM
            dbo.PR_DSC_Product_Description sub
        WHERE
            sub.PR_DSC_PR_ID = PR.PR_ID
   )
LEFT JOIN
    dbo.PR_NAM_Product_Name NAM
ON
    NAM.PR_NAM_PR_ID = PR.PR_ID
AND
    NAM.PR_NAM_ChangedAt = (
        SELECT
            max(sub.PR_NAM_ChangedAt)
        FROM
            dbo.PR_NAM_Product_Name sub
        WHERE
            sub.PR_NAM_PR_ID = PR.PR_ID
   )
LEFT JOIN
    dbo.PR_UID_Product_UUID UID
ON
    UID.PR_UID_PR_ID = PR.PR_ID
LEFT JOIN
    dbo.PR_REP_Product_RetailPrice REP
ON
    REP.PR_REP_PR_ID = PR.PR_ID
AND
    REP.PR_REP_ChangedAt = (
        SELECT
            max(sub.PR_REP_ChangedAt)
        FROM
            dbo.PR_REP_Product_RetailPrice sub
        WHERE
            sub.PR_REP_PR_ID = PR.PR_ID
   );
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lAC_Account viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.lAC_Account AS
SELECT
    AC.AC_ID,
    NAM.AC_NAM_AC_ID,
    NAM.AC_NAM_Account_Username,
    PAS.AC_PAS_AC_ID,
    PAS.AC_PAS_ChangedAt,
    PAS.AC_PAS_Account_Password
FROM
    dbo.AC_Account AC
LEFT JOIN
    dbo.AC_NAM_Account_Username NAM
ON
    NAM.AC_NAM_AC_ID = AC.AC_ID
LEFT JOIN
    dbo.AC_PAS_Account_Password PAS
ON
    PAS.AC_PAS_AC_ID = AC.AC_ID
AND
    PAS.AC_PAS_ChangedAt = (
        SELECT
            max(sub.AC_PAS_ChangedAt)
        FROM
            dbo.AC_PAS_Account_Password sub
        WHERE
            sub.AC_PAS_AC_ID = AC.AC_ID
   );
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- pPR_Product viewed as it was on the given timepoint
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION dbo.pPR_Product (
    changingTimepoint timestamp without time zone
)
RETURNS TABLE (
    PR_ID int,
    PR_DSC_PR_ID int,
    PR_DSC_ChangedAt timestamp,
    PR_DSC_Product_Description varchar(256),
    PR_NAM_PR_ID int,
    PR_NAM_ChangedAt timestamp,
    PR_NAM_Product_Name varchar(256),
    PR_UID_PR_ID int,
    PR_UID_Product_UUID varchar(256),
    PR_REP_PR_ID int,
    PR_REP_ChangedAt timestamp,
    PR_REP_Product_RetailPrice int
) AS '
SELECT
    PR.PR_ID,
    DSC.PR_DSC_PR_ID,
    DSC.PR_DSC_ChangedAt,
    DSC.PR_DSC_Product_Description,
    NAM.PR_NAM_PR_ID,
    NAM.PR_NAM_ChangedAt,
    NAM.PR_NAM_Product_Name,
    UID.PR_UID_PR_ID,
    UID.PR_UID_Product_UUID,
    REP.PR_REP_PR_ID,
    REP.PR_REP_ChangedAt,
    REP.PR_REP_Product_RetailPrice
FROM
    dbo.PR_Product PR
LEFT JOIN
    dbo.rPR_DSC_Product_Description(CAST(changingTimepoint AS timestamp)) DSC
ON
    DSC.PR_DSC_PR_ID = PR.PR_ID
AND
    DSC.PR_DSC_ChangedAt = (
        SELECT
            max(sub.PR_DSC_ChangedAt)
        FROM
            dbo.rPR_DSC_Product_Description(CAST(changingTimepoint AS timestamp)) sub
        WHERE
            sub.PR_DSC_PR_ID = PR.PR_ID
   )
LEFT JOIN
    dbo.rPR_NAM_Product_Name(CAST(changingTimepoint AS timestamp)) NAM
ON
    NAM.PR_NAM_PR_ID = PR.PR_ID
AND
    NAM.PR_NAM_ChangedAt = (
        SELECT
            max(sub.PR_NAM_ChangedAt)
        FROM
            dbo.rPR_NAM_Product_Name(CAST(changingTimepoint AS timestamp)) sub
        WHERE
            sub.PR_NAM_PR_ID = PR.PR_ID
   )
LEFT JOIN
    dbo.PR_UID_Product_UUID UID
ON
    UID.PR_UID_PR_ID = PR.PR_ID
LEFT JOIN
    dbo.rPR_REP_Product_RetailPrice(CAST(changingTimepoint AS timestamp)) REP
ON
    REP.PR_REP_PR_ID = PR.PR_ID
AND
    REP.PR_REP_ChangedAt = (
        SELECT
            max(sub.PR_REP_ChangedAt)
        FROM
            dbo.rPR_REP_Product_RetailPrice(CAST(changingTimepoint AS timestamp)) sub
        WHERE
            sub.PR_REP_PR_ID = PR.PR_ID
   );
' LANGUAGE SQL;
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- pAC_Account viewed as it was on the given timepoint
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION dbo.pAC_Account (
    changingTimepoint timestamp without time zone
)
RETURNS TABLE (
    AC_ID int,
    AC_NAM_AC_ID int,
    AC_NAM_Account_Username varchar(256),
    AC_PAS_AC_ID int,
    AC_PAS_ChangedAt timestamp,
    AC_PAS_Account_Password varchar(256)
) AS '
SELECT
    AC.AC_ID,
    NAM.AC_NAM_AC_ID,
    NAM.AC_NAM_Account_Username,
    PAS.AC_PAS_AC_ID,
    PAS.AC_PAS_ChangedAt,
    PAS.AC_PAS_Account_Password
FROM
    dbo.AC_Account AC
LEFT JOIN
    dbo.AC_NAM_Account_Username NAM
ON
    NAM.AC_NAM_AC_ID = AC.AC_ID
LEFT JOIN
    dbo.rAC_PAS_Account_Password(CAST(changingTimepoint AS timestamp)) PAS
ON
    PAS.AC_PAS_AC_ID = AC.AC_ID
AND
    PAS.AC_PAS_ChangedAt = (
        SELECT
            max(sub.AC_PAS_ChangedAt)
        FROM
            dbo.rAC_PAS_Account_Password(CAST(changingTimepoint AS timestamp)) sub
        WHERE
            sub.AC_PAS_AC_ID = AC.AC_ID
   );
' LANGUAGE SQL;
-- Now perspective ----------------------------------------------------------------------------------------------------
-- nPR_Product viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.nPR_Product AS
SELECT
    *
FROM
    dbo.pPR_Product(LOCALTIMESTAMP);
-- Now perspective ----------------------------------------------------------------------------------------------------
-- nAC_Account viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.nAC_Account AS
SELECT
    *
FROM
    dbo.pAC_Account(LOCALTIMESTAMP);
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
    PR_DSC_PR_ID int,
    PR_DSC_ChangedAt timestamp,
    PR_DSC_Product_Description varchar(256),
    PR_NAM_PR_ID int,
    PR_NAM_ChangedAt timestamp,
    PR_NAM_Product_Name varchar(256),
    PR_UID_PR_ID int,
    PR_UID_Product_UUID varchar(256),
    PR_REP_PR_ID int,
    PR_REP_ChangedAt timestamp,
    PR_REP_Product_RetailPrice int
) AS '
SELECT
    timepoints.inspectedTimepoint,
    timepoints.mnemonic,
    pPR.*
FROM (
    SELECT DISTINCT
        PR_DSC_PR_ID AS PR_ID,
        CAST(PR_DSC_ChangedAt AS timestamp without time zone) AS inspectedTimepoint,
        ''DSC'' AS mnemonic
    FROM
        dbo.PR_DSC_Product_Description
    WHERE
        (selection is null OR selection like ''%DSC%'')
    AND
        PR_DSC_ChangedAt BETWEEN intervalStart AND intervalEnd
    UNION
    SELECT DISTINCT
        PR_NAM_PR_ID AS PR_ID,
        CAST(PR_NAM_ChangedAt AS timestamp without time zone) AS inspectedTimepoint,
        ''NAM'' AS mnemonic
    FROM
        dbo.PR_NAM_Product_Name
    WHERE
        (selection is null OR selection like ''%NAM%'')
    AND
        PR_NAM_ChangedAt BETWEEN intervalStart AND intervalEnd
    UNION
    SELECT DISTINCT
        PR_REP_PR_ID AS PR_ID,
        CAST(PR_REP_ChangedAt AS timestamp without time zone) AS inspectedTimepoint,
        ''REP'' AS mnemonic
    FROM
        dbo.PR_REP_Product_RetailPrice
    WHERE
        (selection is null OR selection like ''%REP%'')
    AND
        PR_REP_ChangedAt BETWEEN intervalStart AND intervalEnd
) timepoints
CROSS JOIN LATERAL
    dbo.pPR_Product(timepoints.inspectedTimepoint) pPR
WHERE
    pPR.PR_ID = timepoints.PR_ID;
' LANGUAGE SQL;
-- Difference perspective ---------------------------------------------------------------------------------------------
-- dAC_Account showing all differences between the given timepoints and optionally for a subset of attributes
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION dbo.dAC_Account (
    intervalStart timestamp without time zone,
    intervalEnd timestamp without time zone,
    selection text = null
) RETURNS TABLE (
    inspectedTimepoint timestamp without time zone,
    mnemonic text,
    AC_ID int,
    AC_NAM_AC_ID int,
    AC_NAM_Account_Username varchar(256),
    AC_PAS_AC_ID int,
    AC_PAS_ChangedAt timestamp,
    AC_PAS_Account_Password varchar(256)
) AS '
SELECT
    timepoints.inspectedTimepoint,
    timepoints.mnemonic,
    pAC.*
FROM (
    SELECT DISTINCT
        AC_PAS_AC_ID AS AC_ID,
        CAST(AC_PAS_ChangedAt AS timestamp without time zone) AS inspectedTimepoint,
        ''PAS'' AS mnemonic
    FROM
        dbo.AC_PAS_Account_Password
    WHERE
        (selection is null OR selection like ''%PAS%'')
    AND
        AC_PAS_ChangedAt BETWEEN intervalStart AND intervalEnd
) timepoints
CROSS JOIN LATERAL
    dbo.pAC_Account(timepoints.inspectedTimepoint) pAC
WHERE
    pAC.AC_ID = timepoints.AC_ID;
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
-- DROP TRIGGER IF EXISTS tcbPR_DSC_Product_Description ON dbo.PR_DSC_Product_Description;
-- DROP FUNCTION IF EXISTS dbo.tcbPR_DSC_Product_Description();
CREATE OR REPLACE FUNCTION dbo.tcbPR_DSC_Product_Description() RETURNS trigger AS '
    BEGIN
        -- temporary table is used to create an insert order 
        -- (so that rows are inserted in order with respect to temporality)
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_PR_DSC_Product_Description (
            PR_DSC_PR_ID int not null,
            PR_DSC_ChangedAt timestamp not null,
            PR_DSC_Product_Description varchar(256) not null,
            PR_DSC_Version bigint not null,
            PR_DSC_StatementType char(1) not null,
            primary key(
                PR_DSC_Version,
                PR_DSC_PR_ID
            )
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcbPR_DSC_Product_Description
BEFORE INSERT ON dbo.PR_DSC_Product_Description
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcbPR_DSC_Product_Description();
-- INSTEAD OF INSERT trigger ------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tciPR_DSC_Product_Description ON dbo.PR_DSC_Product_Description;
-- DROP FUNCTION IF EXISTS dbo.tciPR_DSC_Product_Description();
CREATE OR REPLACE FUNCTION dbo.tciPR_DSC_Product_Description() RETURNS trigger AS '
    BEGIN
        -- insert rows into the temporary table
        INSERT INTO _tmp_PR_DSC_Product_Description
        SELECT
            NEW.PR_DSC_PR_ID,
            NEW.PR_DSC_ChangedAt,
            NEW.PR_DSC_Product_Description,
            0,
            ''X'';
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tciPR_DSC_Product_Description
INSTEAD OF INSERT ON dbo.PR_DSC_Product_Description
FOR EACH ROW
EXECUTE PROCEDURE dbo.tciPR_DSC_Product_Description();
-- AFTER INSERT trigger -----------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tcaPR_DSC_Product_Description ON dbo.PR_DSC_Product_Description;
-- DROP FUNCTION IF EXISTS dbo.tcaPR_DSC_Product_Description();
CREATE OR REPLACE FUNCTION dbo.tcaPR_DSC_Product_Description() RETURNS trigger AS '
    DECLARE maxVersion int;
    DECLARE currentVersion int = 0;
BEGIN
    -- find ranks for inserted data (using self join)
    UPDATE _tmp_PR_DSC_Product_Description
    SET PR_DSC_Version = v.rank
    FROM (
        SELECT
            DENSE_RANK() OVER (
                PARTITION BY
                    PR_DSC_PR_ID
                ORDER BY
                    PR_DSC_ChangedAt ASC
            ) AS rank,
            PR_DSC_PR_ID AS pk
        FROM _tmp_PR_DSC_Product_Description
    ) AS v
    WHERE PR_DSC_PR_ID = v.pk
    AND PR_DSC_Version = 0;
    -- find max version
    SELECT
        MAX(PR_DSC_Version) INTO maxVersion
    FROM
        _tmp_PR_DSC_Product_Description;
    -- is max version NULL?
    IF (maxVersion is null) THEN
        RETURN NULL;
    END IF;
    -- loop over versions
    LOOP
        currentVersion := currentVersion + 1;
        -- set statement types
        UPDATE _tmp_PR_DSC_Product_Description
        SET
            PR_DSC_StatementType =
                CASE
                    WHEN DSC.PR_DSC_PR_ID is not null
                    THEN ''D'' -- duplicate
                    WHEN dbo.rfPR_DSC_Product_Description(
                        v.PR_DSC_PR_ID,
                        v.PR_DSC_Product_Description,
                        v.PR_DSC_ChangedAt
                    ) = 1
                    THEN ''R'' -- restatement
                    ELSE ''N'' -- new statement
                END
        FROM
            _tmp_PR_DSC_Product_Description v
        LEFT JOIN
            dbo._PR_DSC_Product_Description DSC
        ON
            DSC.PR_DSC_PR_ID = v.PR_DSC_PR_ID
        AND
            DSC.PR_DSC_ChangedAt = v.PR_DSC_ChangedAt
        AND
            DSC.PR_DSC_Product_Description = v.PR_DSC_Product_Description
        WHERE
            v.PR_DSC_Version = currentVersion;
        -- insert data into attribute table
        INSERT INTO dbo._PR_DSC_Product_Description (
            PR_DSC_PR_ID,
            PR_DSC_ChangedAt,
            PR_DSC_Product_Description
        )
        SELECT
            PR_DSC_PR_ID,
            PR_DSC_ChangedAt,
            PR_DSC_Product_Description
        FROM
            _tmp_PR_DSC_Product_Description
        WHERE
            PR_DSC_Version = currentVersion
        AND
            PR_DSC_StatementType in (''N'');
        EXIT WHEN currentVersion >= maxVersion;
    END LOOP;
    DROP TABLE IF EXISTS _tmp_PR_DSC_Product_Description;
    RETURN NULL;
END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcaPR_DSC_Product_Description
AFTER INSERT ON dbo.PR_DSC_Product_Description
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcaPR_DSC_Product_Description();
-- BEFORE INSERT trigger ----------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tcbPR_NAM_Product_Name ON dbo.PR_NAM_Product_Name;
-- DROP FUNCTION IF EXISTS dbo.tcbPR_NAM_Product_Name();
CREATE OR REPLACE FUNCTION dbo.tcbPR_NAM_Product_Name() RETURNS trigger AS '
    BEGIN
        -- temporary table is used to create an insert order 
        -- (so that rows are inserted in order with respect to temporality)
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_PR_NAM_Product_Name (
            PR_NAM_PR_ID int not null,
            PR_NAM_ChangedAt timestamp not null,
            PR_NAM_Product_Name varchar(256) not null,
            PR_NAM_Version bigint not null,
            PR_NAM_StatementType char(1) not null,
            primary key(
                PR_NAM_Version,
                PR_NAM_PR_ID
            )
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcbPR_NAM_Product_Name
BEFORE INSERT ON dbo.PR_NAM_Product_Name
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcbPR_NAM_Product_Name();
-- INSTEAD OF INSERT trigger ------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tciPR_NAM_Product_Name ON dbo.PR_NAM_Product_Name;
-- DROP FUNCTION IF EXISTS dbo.tciPR_NAM_Product_Name();
CREATE OR REPLACE FUNCTION dbo.tciPR_NAM_Product_Name() RETURNS trigger AS '
    BEGIN
        -- insert rows into the temporary table
        INSERT INTO _tmp_PR_NAM_Product_Name
        SELECT
            NEW.PR_NAM_PR_ID,
            NEW.PR_NAM_ChangedAt,
            NEW.PR_NAM_Product_Name,
            0,
            ''X'';
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tciPR_NAM_Product_Name
INSTEAD OF INSERT ON dbo.PR_NAM_Product_Name
FOR EACH ROW
EXECUTE PROCEDURE dbo.tciPR_NAM_Product_Name();
-- AFTER INSERT trigger -----------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tcaPR_NAM_Product_Name ON dbo.PR_NAM_Product_Name;
-- DROP FUNCTION IF EXISTS dbo.tcaPR_NAM_Product_Name();
CREATE OR REPLACE FUNCTION dbo.tcaPR_NAM_Product_Name() RETURNS trigger AS '
    DECLARE maxVersion int;
    DECLARE currentVersion int = 0;
BEGIN
    -- find ranks for inserted data (using self join)
    UPDATE _tmp_PR_NAM_Product_Name
    SET PR_NAM_Version = v.rank
    FROM (
        SELECT
            DENSE_RANK() OVER (
                PARTITION BY
                    PR_NAM_PR_ID
                ORDER BY
                    PR_NAM_ChangedAt ASC
            ) AS rank,
            PR_NAM_PR_ID AS pk
        FROM _tmp_PR_NAM_Product_Name
    ) AS v
    WHERE PR_NAM_PR_ID = v.pk
    AND PR_NAM_Version = 0;
    -- find max version
    SELECT
        MAX(PR_NAM_Version) INTO maxVersion
    FROM
        _tmp_PR_NAM_Product_Name;
    -- is max version NULL?
    IF (maxVersion is null) THEN
        RETURN NULL;
    END IF;
    -- loop over versions
    LOOP
        currentVersion := currentVersion + 1;
        -- set statement types
        UPDATE _tmp_PR_NAM_Product_Name
        SET
            PR_NAM_StatementType =
                CASE
                    WHEN NAM.PR_NAM_PR_ID is not null
                    THEN ''D'' -- duplicate
                    WHEN dbo.rfPR_NAM_Product_Name(
                        v.PR_NAM_PR_ID,
                        v.PR_NAM_Product_Name,
                        v.PR_NAM_ChangedAt
                    ) = 1
                    THEN ''R'' -- restatement
                    ELSE ''N'' -- new statement
                END
        FROM
            _tmp_PR_NAM_Product_Name v
        LEFT JOIN
            dbo._PR_NAM_Product_Name NAM
        ON
            NAM.PR_NAM_PR_ID = v.PR_NAM_PR_ID
        AND
            NAM.PR_NAM_ChangedAt = v.PR_NAM_ChangedAt
        AND
            NAM.PR_NAM_Product_Name = v.PR_NAM_Product_Name
        WHERE
            v.PR_NAM_Version = currentVersion;
        -- insert data into attribute table
        INSERT INTO dbo._PR_NAM_Product_Name (
            PR_NAM_PR_ID,
            PR_NAM_ChangedAt,
            PR_NAM_Product_Name
        )
        SELECT
            PR_NAM_PR_ID,
            PR_NAM_ChangedAt,
            PR_NAM_Product_Name
        FROM
            _tmp_PR_NAM_Product_Name
        WHERE
            PR_NAM_Version = currentVersion
        AND
            PR_NAM_StatementType in (''N'');
        EXIT WHEN currentVersion >= maxVersion;
    END LOOP;
    DROP TABLE IF EXISTS _tmp_PR_NAM_Product_Name;
    RETURN NULL;
END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcaPR_NAM_Product_Name
AFTER INSERT ON dbo.PR_NAM_Product_Name
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcaPR_NAM_Product_Name();
-- BEFORE INSERT trigger ----------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tcbPR_UID_Product_UUID ON dbo.PR_UID_Product_UUID;
-- DROP FUNCTION IF EXISTS dbo.tcbPR_UID_Product_UUID();
CREATE OR REPLACE FUNCTION dbo.tcbPR_UID_Product_UUID() RETURNS trigger AS '
    BEGIN
        -- temporary table is used to create an insert order 
        -- (so that rows are inserted in order with respect to temporality)
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_PR_UID_Product_UUID (
            PR_UID_PR_ID int not null,
            PR_UID_Product_UUID varchar(256) not null,
            PR_UID_Version bigint not null,
            PR_UID_StatementType char(1) not null,
            primary key(
                PR_UID_Version,
                PR_UID_PR_ID
            )
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcbPR_UID_Product_UUID
BEFORE INSERT ON dbo.PR_UID_Product_UUID
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcbPR_UID_Product_UUID();
-- INSTEAD OF INSERT trigger ------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tciPR_UID_Product_UUID ON dbo.PR_UID_Product_UUID;
-- DROP FUNCTION IF EXISTS dbo.tciPR_UID_Product_UUID();
CREATE OR REPLACE FUNCTION dbo.tciPR_UID_Product_UUID() RETURNS trigger AS '
    BEGIN
        -- insert rows into the temporary table
        INSERT INTO _tmp_PR_UID_Product_UUID
        SELECT
            NEW.PR_UID_PR_ID,
            NEW.PR_UID_Product_UUID,
            1,
            ''X'';
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tciPR_UID_Product_UUID
INSTEAD OF INSERT ON dbo.PR_UID_Product_UUID
FOR EACH ROW
EXECUTE PROCEDURE dbo.tciPR_UID_Product_UUID();
-- AFTER INSERT trigger -----------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tcaPR_UID_Product_UUID ON dbo.PR_UID_Product_UUID;
-- DROP FUNCTION IF EXISTS dbo.tcaPR_UID_Product_UUID();
CREATE OR REPLACE FUNCTION dbo.tcaPR_UID_Product_UUID() RETURNS trigger AS '
    DECLARE maxVersion int;
    DECLARE currentVersion int = 0;
BEGIN
    -- find max version
    SELECT
        MAX(PR_UID_Version) INTO maxVersion
    FROM
        _tmp_PR_UID_Product_UUID;
    -- is max version NULL?
    IF (maxVersion is null) THEN
        RETURN NULL;
    END IF;
    -- loop over versions
    LOOP
        currentVersion := currentVersion + 1;
        -- set statement types
        UPDATE _tmp_PR_UID_Product_UUID
        SET
            PR_UID_StatementType =
                CASE
                    WHEN UID.PR_UID_PR_ID is not null
                    THEN ''D'' -- duplicate
                    ELSE ''N'' -- new statement
                END
        FROM
            _tmp_PR_UID_Product_UUID v
        LEFT JOIN
            dbo._PR_UID_Product_UUID UID
        ON
            UID.PR_UID_PR_ID = v.PR_UID_PR_ID
        AND
            UID.PR_UID_Product_UUID = v.PR_UID_Product_UUID
        WHERE
            v.PR_UID_Version = currentVersion;
        -- insert data into attribute table
        INSERT INTO dbo._PR_UID_Product_UUID (
            PR_UID_PR_ID,
            PR_UID_Product_UUID
        )
        SELECT
            PR_UID_PR_ID,
            PR_UID_Product_UUID
        FROM
            _tmp_PR_UID_Product_UUID
        WHERE
            PR_UID_Version = currentVersion
        AND
            PR_UID_StatementType in (''N'');
        EXIT WHEN currentVersion >= maxVersion;
    END LOOP;
    DROP TABLE IF EXISTS _tmp_PR_UID_Product_UUID;
    RETURN NULL;
END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcaPR_UID_Product_UUID
AFTER INSERT ON dbo.PR_UID_Product_UUID
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcaPR_UID_Product_UUID();
-- BEFORE INSERT trigger ----------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tcbPR_REP_Product_RetailPrice ON dbo.PR_REP_Product_RetailPrice;
-- DROP FUNCTION IF EXISTS dbo.tcbPR_REP_Product_RetailPrice();
CREATE OR REPLACE FUNCTION dbo.tcbPR_REP_Product_RetailPrice() RETURNS trigger AS '
    BEGIN
        -- temporary table is used to create an insert order 
        -- (so that rows are inserted in order with respect to temporality)
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_PR_REP_Product_RetailPrice (
            PR_REP_PR_ID int not null,
            PR_REP_ChangedAt timestamp not null,
            PR_REP_Product_RetailPrice int not null,
            PR_REP_Version bigint not null,
            PR_REP_StatementType char(1) not null,
            primary key(
                PR_REP_Version,
                PR_REP_PR_ID
            )
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcbPR_REP_Product_RetailPrice
BEFORE INSERT ON dbo.PR_REP_Product_RetailPrice
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcbPR_REP_Product_RetailPrice();
-- INSTEAD OF INSERT trigger ------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tciPR_REP_Product_RetailPrice ON dbo.PR_REP_Product_RetailPrice;
-- DROP FUNCTION IF EXISTS dbo.tciPR_REP_Product_RetailPrice();
CREATE OR REPLACE FUNCTION dbo.tciPR_REP_Product_RetailPrice() RETURNS trigger AS '
    BEGIN
        -- insert rows into the temporary table
        INSERT INTO _tmp_PR_REP_Product_RetailPrice
        SELECT
            NEW.PR_REP_PR_ID,
            NEW.PR_REP_ChangedAt,
            NEW.PR_REP_Product_RetailPrice,
            0,
            ''X'';
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tciPR_REP_Product_RetailPrice
INSTEAD OF INSERT ON dbo.PR_REP_Product_RetailPrice
FOR EACH ROW
EXECUTE PROCEDURE dbo.tciPR_REP_Product_RetailPrice();
-- AFTER INSERT trigger -----------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tcaPR_REP_Product_RetailPrice ON dbo.PR_REP_Product_RetailPrice;
-- DROP FUNCTION IF EXISTS dbo.tcaPR_REP_Product_RetailPrice();
CREATE OR REPLACE FUNCTION dbo.tcaPR_REP_Product_RetailPrice() RETURNS trigger AS '
    DECLARE maxVersion int;
    DECLARE currentVersion int = 0;
BEGIN
    -- find ranks for inserted data (using self join)
    UPDATE _tmp_PR_REP_Product_RetailPrice
    SET PR_REP_Version = v.rank
    FROM (
        SELECT
            DENSE_RANK() OVER (
                PARTITION BY
                    PR_REP_PR_ID
                ORDER BY
                    PR_REP_ChangedAt ASC
            ) AS rank,
            PR_REP_PR_ID AS pk
        FROM _tmp_PR_REP_Product_RetailPrice
    ) AS v
    WHERE PR_REP_PR_ID = v.pk
    AND PR_REP_Version = 0;
    -- find max version
    SELECT
        MAX(PR_REP_Version) INTO maxVersion
    FROM
        _tmp_PR_REP_Product_RetailPrice;
    -- is max version NULL?
    IF (maxVersion is null) THEN
        RETURN NULL;
    END IF;
    -- loop over versions
    LOOP
        currentVersion := currentVersion + 1;
        -- set statement types
        UPDATE _tmp_PR_REP_Product_RetailPrice
        SET
            PR_REP_StatementType =
                CASE
                    WHEN REP.PR_REP_PR_ID is not null
                    THEN ''D'' -- duplicate
                    WHEN dbo.rfPR_REP_Product_RetailPrice(
                        v.PR_REP_PR_ID,
                        v.PR_REP_Product_RetailPrice,
                        v.PR_REP_ChangedAt
                    ) = 1
                    THEN ''R'' -- restatement
                    ELSE ''N'' -- new statement
                END
        FROM
            _tmp_PR_REP_Product_RetailPrice v
        LEFT JOIN
            dbo._PR_REP_Product_RetailPrice REP
        ON
            REP.PR_REP_PR_ID = v.PR_REP_PR_ID
        AND
            REP.PR_REP_ChangedAt = v.PR_REP_ChangedAt
        AND
            REP.PR_REP_Product_RetailPrice = v.PR_REP_Product_RetailPrice
        WHERE
            v.PR_REP_Version = currentVersion;
        -- insert data into attribute table
        INSERT INTO dbo._PR_REP_Product_RetailPrice (
            PR_REP_PR_ID,
            PR_REP_ChangedAt,
            PR_REP_Product_RetailPrice
        )
        SELECT
            PR_REP_PR_ID,
            PR_REP_ChangedAt,
            PR_REP_Product_RetailPrice
        FROM
            _tmp_PR_REP_Product_RetailPrice
        WHERE
            PR_REP_Version = currentVersion
        AND
            PR_REP_StatementType in (''N'');
        EXIT WHEN currentVersion >= maxVersion;
    END LOOP;
    DROP TABLE IF EXISTS _tmp_PR_REP_Product_RetailPrice;
    RETURN NULL;
END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcaPR_REP_Product_RetailPrice
AFTER INSERT ON dbo.PR_REP_Product_RetailPrice
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcaPR_REP_Product_RetailPrice();
-- BEFORE INSERT trigger ----------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tcbAC_NAM_Account_Username ON dbo.AC_NAM_Account_Username;
-- DROP FUNCTION IF EXISTS dbo.tcbAC_NAM_Account_Username();
CREATE OR REPLACE FUNCTION dbo.tcbAC_NAM_Account_Username() RETURNS trigger AS '
    BEGIN
        -- temporary table is used to create an insert order 
        -- (so that rows are inserted in order with respect to temporality)
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_AC_NAM_Account_Username (
            AC_NAM_AC_ID int not null,
            AC_NAM_Account_Username varchar(256) not null,
            AC_NAM_Version bigint not null,
            AC_NAM_StatementType char(1) not null,
            primary key(
                AC_NAM_Version,
                AC_NAM_AC_ID
            )
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcbAC_NAM_Account_Username
BEFORE INSERT ON dbo.AC_NAM_Account_Username
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcbAC_NAM_Account_Username();
-- INSTEAD OF INSERT trigger ------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tciAC_NAM_Account_Username ON dbo.AC_NAM_Account_Username;
-- DROP FUNCTION IF EXISTS dbo.tciAC_NAM_Account_Username();
CREATE OR REPLACE FUNCTION dbo.tciAC_NAM_Account_Username() RETURNS trigger AS '
    BEGIN
        -- insert rows into the temporary table
        INSERT INTO _tmp_AC_NAM_Account_Username
        SELECT
            NEW.AC_NAM_AC_ID,
            NEW.AC_NAM_Account_Username,
            1,
            ''X'';
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tciAC_NAM_Account_Username
INSTEAD OF INSERT ON dbo.AC_NAM_Account_Username
FOR EACH ROW
EXECUTE PROCEDURE dbo.tciAC_NAM_Account_Username();
-- AFTER INSERT trigger -----------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tcaAC_NAM_Account_Username ON dbo.AC_NAM_Account_Username;
-- DROP FUNCTION IF EXISTS dbo.tcaAC_NAM_Account_Username();
CREATE OR REPLACE FUNCTION dbo.tcaAC_NAM_Account_Username() RETURNS trigger AS '
    DECLARE maxVersion int;
    DECLARE currentVersion int = 0;
BEGIN
    -- find max version
    SELECT
        MAX(AC_NAM_Version) INTO maxVersion
    FROM
        _tmp_AC_NAM_Account_Username;
    -- is max version NULL?
    IF (maxVersion is null) THEN
        RETURN NULL;
    END IF;
    -- loop over versions
    LOOP
        currentVersion := currentVersion + 1;
        -- set statement types
        UPDATE _tmp_AC_NAM_Account_Username
        SET
            AC_NAM_StatementType =
                CASE
                    WHEN NAM.AC_NAM_AC_ID is not null
                    THEN ''D'' -- duplicate
                    ELSE ''N'' -- new statement
                END
        FROM
            _tmp_AC_NAM_Account_Username v
        LEFT JOIN
            dbo._AC_NAM_Account_Username NAM
        ON
            NAM.AC_NAM_AC_ID = v.AC_NAM_AC_ID
        AND
            NAM.AC_NAM_Account_Username = v.AC_NAM_Account_Username
        WHERE
            v.AC_NAM_Version = currentVersion;
        -- insert data into attribute table
        INSERT INTO dbo._AC_NAM_Account_Username (
            AC_NAM_AC_ID,
            AC_NAM_Account_Username
        )
        SELECT
            AC_NAM_AC_ID,
            AC_NAM_Account_Username
        FROM
            _tmp_AC_NAM_Account_Username
        WHERE
            AC_NAM_Version = currentVersion
        AND
            AC_NAM_StatementType in (''N'');
        EXIT WHEN currentVersion >= maxVersion;
    END LOOP;
    DROP TABLE IF EXISTS _tmp_AC_NAM_Account_Username;
    RETURN NULL;
END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcaAC_NAM_Account_Username
AFTER INSERT ON dbo.AC_NAM_Account_Username
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcaAC_NAM_Account_Username();
-- BEFORE INSERT trigger ----------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tcbAC_PAS_Account_Password ON dbo.AC_PAS_Account_Password;
-- DROP FUNCTION IF EXISTS dbo.tcbAC_PAS_Account_Password();
CREATE OR REPLACE FUNCTION dbo.tcbAC_PAS_Account_Password() RETURNS trigger AS '
    BEGIN
        -- temporary table is used to create an insert order 
        -- (so that rows are inserted in order with respect to temporality)
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_AC_PAS_Account_Password (
            AC_PAS_AC_ID int not null,
            AC_PAS_ChangedAt timestamp not null,
            AC_PAS_Account_Password varchar(256) not null,
            AC_PAS_Version bigint not null,
            AC_PAS_StatementType char(1) not null,
            primary key(
                AC_PAS_Version,
                AC_PAS_AC_ID
            )
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcbAC_PAS_Account_Password
BEFORE INSERT ON dbo.AC_PAS_Account_Password
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcbAC_PAS_Account_Password();
-- INSTEAD OF INSERT trigger ------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tciAC_PAS_Account_Password ON dbo.AC_PAS_Account_Password;
-- DROP FUNCTION IF EXISTS dbo.tciAC_PAS_Account_Password();
CREATE OR REPLACE FUNCTION dbo.tciAC_PAS_Account_Password() RETURNS trigger AS '
    BEGIN
        -- insert rows into the temporary table
        INSERT INTO _tmp_AC_PAS_Account_Password
        SELECT
            NEW.AC_PAS_AC_ID,
            NEW.AC_PAS_ChangedAt,
            NEW.AC_PAS_Account_Password,
            0,
            ''X'';
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tciAC_PAS_Account_Password
INSTEAD OF INSERT ON dbo.AC_PAS_Account_Password
FOR EACH ROW
EXECUTE PROCEDURE dbo.tciAC_PAS_Account_Password();
-- AFTER INSERT trigger -----------------------------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS tcaAC_PAS_Account_Password ON dbo.AC_PAS_Account_Password;
-- DROP FUNCTION IF EXISTS dbo.tcaAC_PAS_Account_Password();
CREATE OR REPLACE FUNCTION dbo.tcaAC_PAS_Account_Password() RETURNS trigger AS '
    DECLARE maxVersion int;
    DECLARE currentVersion int = 0;
BEGIN
    -- find ranks for inserted data (using self join)
    UPDATE _tmp_AC_PAS_Account_Password
    SET AC_PAS_Version = v.rank
    FROM (
        SELECT
            DENSE_RANK() OVER (
                PARTITION BY
                    AC_PAS_AC_ID
                ORDER BY
                    AC_PAS_ChangedAt ASC
            ) AS rank,
            AC_PAS_AC_ID AS pk
        FROM _tmp_AC_PAS_Account_Password
    ) AS v
    WHERE AC_PAS_AC_ID = v.pk
    AND AC_PAS_Version = 0;
    -- find max version
    SELECT
        MAX(AC_PAS_Version) INTO maxVersion
    FROM
        _tmp_AC_PAS_Account_Password;
    -- is max version NULL?
    IF (maxVersion is null) THEN
        RETURN NULL;
    END IF;
    -- loop over versions
    LOOP
        currentVersion := currentVersion + 1;
        -- set statement types
        UPDATE _tmp_AC_PAS_Account_Password
        SET
            AC_PAS_StatementType =
                CASE
                    WHEN PAS.AC_PAS_AC_ID is not null
                    THEN ''D'' -- duplicate
                    WHEN dbo.rfAC_PAS_Account_Password(
                        v.AC_PAS_AC_ID,
                        v.AC_PAS_Account_Password,
                        v.AC_PAS_ChangedAt
                    ) = 1
                    THEN ''R'' -- restatement
                    ELSE ''N'' -- new statement
                END
        FROM
            _tmp_AC_PAS_Account_Password v
        LEFT JOIN
            dbo._AC_PAS_Account_Password PAS
        ON
            PAS.AC_PAS_AC_ID = v.AC_PAS_AC_ID
        AND
            PAS.AC_PAS_ChangedAt = v.AC_PAS_ChangedAt
        AND
            PAS.AC_PAS_Account_Password = v.AC_PAS_Account_Password
        WHERE
            v.AC_PAS_Version = currentVersion;
        -- insert data into attribute table
        INSERT INTO dbo._AC_PAS_Account_Password (
            AC_PAS_AC_ID,
            AC_PAS_ChangedAt,
            AC_PAS_Account_Password
        )
        SELECT
            AC_PAS_AC_ID,
            AC_PAS_ChangedAt,
            AC_PAS_Account_Password
        FROM
            _tmp_AC_PAS_Account_Password
        WHERE
            AC_PAS_Version = currentVersion
        AND
            AC_PAS_StatementType in (''N'');
        EXIT WHEN currentVersion >= maxVersion;
    END LOOP;
    DROP TABLE IF EXISTS _tmp_AC_PAS_Account_Password;
    RETURN NULL;
END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcaAC_PAS_Account_Password
AFTER INSERT ON dbo.AC_PAS_Account_Password
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcaAC_PAS_Account_Password();
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
--DROP TRIGGER IF EXISTS itb_lPR_Product ON dbo.lPR_Product;
--DROP FUNCTION IF EXISTS dbo.itb_lPR_Product();
CREATE OR REPLACE FUNCTION dbo.itb_lPR_Product() RETURNS trigger AS '
    BEGIN
        -- create temporary table to keep inserted rows in
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_it_PR_Product (
            PR_ID int not null,
            PR_DSC_PR_ID int null,
            PR_DSC_ChangedAt timestamp null,
            PR_DSC_Product_Description varchar(256) null,
            PR_NAM_PR_ID int null,
            PR_NAM_ChangedAt timestamp null,
            PR_NAM_Product_Name varchar(256) null,
            PR_UID_PR_ID int null,
            PR_UID_Product_UUID varchar(256) null,
            PR_REP_PR_ID int null,
            PR_REP_ChangedAt timestamp null,
            PR_REP_Product_RetailPrice int null
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER itb_lPR_Product
BEFORE INSERT ON dbo.lPR_Product
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.itb_lPR_Product(); 
-- INSTEAD OF INSERT trigger ----------------------------------------------------------------------------------------------------
--DROP TRIGGER IF EXISTS iti_lPR_Product ON dbo.lPR_Product;
--DROP FUNCTION IF EXISTS dbo.iti_lPR_Product();
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
            PR_DSC_PR_ID,
            PR_DSC_ChangedAt,
            PR_DSC_Product_Description,
            PR_NAM_PR_ID,
            PR_NAM_ChangedAt,
            PR_NAM_Product_Name,
            PR_UID_PR_ID,
            PR_UID_Product_UUID,
            PR_REP_PR_ID,
            PR_REP_ChangedAt,
            PR_REP_Product_RetailPrice
    	) VALUES (
    	    NEW.PR_ID,
            COALESCE(NEW.PR_DSC_PR_ID, NEW.PR_ID),
            COALESCE(NEW.PR_DSC_ChangedAt, CAST(LOCALTIMESTAMP AS timestamp)),
            NEW.PR_DSC_Product_Description,
            COALESCE(NEW.PR_NAM_PR_ID, NEW.PR_ID),
            COALESCE(NEW.PR_NAM_ChangedAt, CAST(LOCALTIMESTAMP AS timestamp)),
            NEW.PR_NAM_Product_Name,
            COALESCE(NEW.PR_UID_PR_ID, NEW.PR_ID),
            NEW.PR_UID_Product_UUID,
            COALESCE(NEW.PR_REP_PR_ID, NEW.PR_ID),
            COALESCE(NEW.PR_REP_ChangedAt, CAST(LOCALTIMESTAMP AS timestamp)),
            NEW.PR_REP_Product_RetailPrice
    	);
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER iti_lPR_Product
INSTEAD OF INSERT ON dbo.lPR_Product
FOR EACH ROW
EXECUTE PROCEDURE dbo.iti_lPR_Product();
-- AFTER INSERT trigger ---------------------------------------------------------------------------------------------------------
--DROP TRIGGER IF EXISTS ita_lPR_Product ON dbo.lPR_Product;
--DROP FUNCTION IF EXISTS dbo.ita_lPR_Product();
CREATE OR REPLACE FUNCTION dbo.ita_lPR_Product() RETURNS trigger AS '
    BEGIN
        INSERT INTO dbo.PR_DSC_Product_Description (
            PR_DSC_PR_ID,
            PR_DSC_ChangedAt,
            PR_DSC_Product_Description
        )
        SELECT
            i.PR_DSC_PR_ID,
            i.PR_DSC_ChangedAt,
            i.PR_DSC_Product_Description
        FROM
            _tmp_it_PR_Product i
        WHERE
            i.PR_DSC_Product_Description is not null;
        INSERT INTO dbo.PR_NAM_Product_Name (
            PR_NAM_PR_ID,
            PR_NAM_ChangedAt,
            PR_NAM_Product_Name
        )
        SELECT
            i.PR_NAM_PR_ID,
            i.PR_NAM_ChangedAt,
            i.PR_NAM_Product_Name
        FROM
            _tmp_it_PR_Product i
        WHERE
            i.PR_NAM_Product_Name is not null;
        INSERT INTO dbo.PR_UID_Product_UUID (
            PR_UID_PR_ID,
            PR_UID_Product_UUID
        )
        SELECT
            i.PR_UID_PR_ID,
            i.PR_UID_Product_UUID
        FROM
            _tmp_it_PR_Product i
        WHERE
            i.PR_UID_Product_UUID is not null;
        INSERT INTO dbo.PR_REP_Product_RetailPrice (
            PR_REP_PR_ID,
            PR_REP_ChangedAt,
            PR_REP_Product_RetailPrice
        )
        SELECT
            i.PR_REP_PR_ID,
            i.PR_REP_ChangedAt,
            i.PR_REP_Product_RetailPrice
        FROM
            _tmp_it_PR_Product i
        WHERE
            i.PR_REP_Product_RetailPrice is not null;
        DROP TABLE IF EXISTS _tmp_it_PR_Product;
        RETURN NULL;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER ita_lPR_Product
AFTER INSERT ON dbo.lPR_Product
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.ita_lPR_Product();
-- BEFORE INSERT trigger --------------------------------------------------------------------------------------------------------
--DROP TRIGGER IF EXISTS itb_lAC_Account ON dbo.lAC_Account;
--DROP FUNCTION IF EXISTS dbo.itb_lAC_Account();
CREATE OR REPLACE FUNCTION dbo.itb_lAC_Account() RETURNS trigger AS '
    BEGIN
        -- create temporary table to keep inserted rows in
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_it_AC_Account (
            AC_ID int not null,
            AC_NAM_AC_ID int null,
            AC_NAM_Account_Username varchar(256) null,
            AC_PAS_AC_ID int null,
            AC_PAS_ChangedAt timestamp null,
            AC_PAS_Account_Password varchar(256) null
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER itb_lAC_Account
BEFORE INSERT ON dbo.lAC_Account
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.itb_lAC_Account(); 
-- INSTEAD OF INSERT trigger ----------------------------------------------------------------------------------------------------
--DROP TRIGGER IF EXISTS iti_lAC_Account ON dbo.lAC_Account;
--DROP FUNCTION IF EXISTS dbo.iti_lAC_Account();
CREATE OR REPLACE FUNCTION dbo.iti_lAC_Account() RETURNS trigger AS '
    BEGIN
        -- generate anchor ID (if not provided)
        IF (NEW.AC_ID IS NULL) THEN 
            INSERT INTO dbo.AC_Account (
                AC_Dummy
            ) VALUES (
                null
            );
            SELECT
                lastval() 
            INTO NEW.AC_ID;
        -- if anchor ID is provided then let''s insert it into the anchor table
        -- but only if that ID is not present in the anchor table
        ELSE
            INSERT INTO dbo.AC_Account (
                AC_ID
            )
            SELECT
                NEW.AC_ID
            WHERE NOT EXISTS(
	            SELECT
	                AC_ID 
	            FROM dbo.AC_Account
	            WHERE AC_ID = NEW.AC_ID
	            LIMIT 1
            );
        END IF;
        -- insert row into temporary table
    	INSERT INTO _tmp_it_AC_Account (
            AC_ID,
            AC_NAM_AC_ID,
            AC_NAM_Account_Username,
            AC_PAS_AC_ID,
            AC_PAS_ChangedAt,
            AC_PAS_Account_Password
    	) VALUES (
    	    NEW.AC_ID,
            COALESCE(NEW.AC_NAM_AC_ID, NEW.AC_ID),
            NEW.AC_NAM_Account_Username,
            COALESCE(NEW.AC_PAS_AC_ID, NEW.AC_ID),
            COALESCE(NEW.AC_PAS_ChangedAt, CAST(LOCALTIMESTAMP AS timestamp)),
            NEW.AC_PAS_Account_Password
    	);
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER iti_lAC_Account
INSTEAD OF INSERT ON dbo.lAC_Account
FOR EACH ROW
EXECUTE PROCEDURE dbo.iti_lAC_Account();
-- AFTER INSERT trigger ---------------------------------------------------------------------------------------------------------
--DROP TRIGGER IF EXISTS ita_lAC_Account ON dbo.lAC_Account;
--DROP FUNCTION IF EXISTS dbo.ita_lAC_Account();
CREATE OR REPLACE FUNCTION dbo.ita_lAC_Account() RETURNS trigger AS '
    BEGIN
        INSERT INTO dbo.AC_NAM_Account_Username (
            AC_NAM_AC_ID,
            AC_NAM_Account_Username
        )
        SELECT
            i.AC_NAM_AC_ID,
            i.AC_NAM_Account_Username
        FROM
            _tmp_it_AC_Account i
        WHERE
            i.AC_NAM_Account_Username is not null;
        INSERT INTO dbo.AC_PAS_Account_Password (
            AC_PAS_AC_ID,
            AC_PAS_ChangedAt,
            AC_PAS_Account_Password
        )
        SELECT
            i.AC_PAS_AC_ID,
            i.AC_PAS_ChangedAt,
            i.AC_PAS_Account_Password
        FROM
            _tmp_it_AC_Account i
        WHERE
            i.AC_PAS_Account_Password is not null;
        DROP TABLE IF EXISTS _tmp_it_AC_Account;
        RETURN NULL;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER ita_lAC_Account
AFTER INSERT ON dbo.lAC_Account
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.ita_lAC_Account();
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
DROP VIEW IF EXISTS dbo.nAC_has_TK_belongsTo;
DROP FUNCTION IF EXISTS dbo.pAC_has_TK_belongsTo(
    timestamp without time zone
);
DROP VIEW IF EXISTS dbo.lAC_has_TK_belongsTo;
*/
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lAC_has_TK_belongsTo viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.lAC_has_TK_belongsTo AS
SELECT
    tie.AC_ID_has,
    tie.TK_ID_belongsTo
FROM
    dbo.AC_has_TK_belongsTo tie;
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- pAC_has_TK_belongsTo viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION dbo.pAC_has_TK_belongsTo (
    changingTimepoint timestamp without time zone
)
RETURNS TABLE (
    AC_ID_has int,
    TK_ID_belongsTo int
) AS '
SELECT
    tie.AC_ID_has,
    tie.TK_ID_belongsTo
FROM
    dbo.AC_has_TK_belongsTo tie;
' LANGUAGE SQL;
-- Now perspective ----------------------------------------------------------------------------------------------------
-- nAC_has_TK_belongsTo viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.nAC_has_TK_belongsTo AS
SELECT
    *
FROM
    dbo.pAC_has_TK_belongsTo(LOCALTIMESTAMP);
-- DESCRIPTIONS -------------------------------------------------------------------------------------------------------