# Transaction Producers

There are might be different producers of transaction - files, DBs, API calls,
RabbitMQ, Kafka, etc. Each producer should have a `#next` method which returns
the next transaction of nil if there are no more transactions.
