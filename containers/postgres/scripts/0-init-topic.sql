CREATE schema IF NOT EXISTS topic;

CREATE TABLE IF NOT EXISTS topic.appEvents
(
	eventId UUID PRIMARY KEY,
	nextEventId UUID NOT NULL UNIQUE,
	lastEventId UUID,
	aggregateId UUID NOT NULL,
	creationDateTime INT NOT NULL,
	payload JSON NOT NULL
);