-- database has been tested with STRICT and check constrints,
-- so they can be disabled now for speed and compatability
PRAGMA ignore_check_constraints = true;
CREATE TABLE Account (
    accountID INTEGER PRIMARY KEY,
    statementFrequency TEXT NOT NULL,  -- frequency
    creationDate TEXT NOT NULL,
    CHECK (statementFrequency IN ('Monthly', 'Weekly', 'Per transaction'))
);
CREATE TABLE Loan (
    loanID INTEGER PRIMARY KEY,
    dispID INTEGER NOT NULL,
    loanDate TEXT NOT NULL,
    loanAmount INTEGER NOT NULL,
    loanDuration INTEGER NOT NULL,
    loanPayments INTEGER NOT NULL,
    loanStatus TEXT NOT NULL,
    FOREIGN KEY (dispID) REFERENCES Disposition(dispID),
    CHECK (loanStatus in ('A', 'B', 'C', 'D'))
);
CREATE TABLE StandingOrder (
    orderID INTEGER PRIMARY KEY,
    dispID INTEGER NOT NULL,
    bankTo TEXT NOT NULL,
    accountTo INTEGER NOT NULL,
    orderAmount REAL NOT NULL,
    paymentType TEXT,
    FOREIGN KEY (dispID) REFERENCES Disposition(dispID)
);
CREATE TABLE BankTransaction (  -- Transaction is a reserved word
    transID INTEGER PRIMARY KEY,
    dispID INTEGER NOT NULL,
    transDate TEXT NOT NULL,
    transType TEXT NOT NULL,
    operation TEXT,
    transAmount REAL NOT NULL,
    balance REAL NOT NULL,
    transDetail TEXT,
    partnerBank TEXT,
    partnerAccount INTEGER,
    FOREIGN KEY (dispID) REFERENCES Disposition(dispID),
    CHECK (transType in ('Credit', 'Withdrawal', 'Withdrawal in cash')),
    CHECK (operation in ('Credit in cash', 'Collection from another bank', 'Credit card withdrawal', 'Remittance to another bank', 'Withdrawal in cash')),
    CHECK (transAmount >= 0)
);
-- Line up sooo nice. awesome
CREATE TABLE Client (
    clientID INTEGER PRIMARY KEY,
    cityID INTEGER NOT NULL,  -- a1
    birthDate TEXT NOT NULL,  -- birth_number
    gender INTEGER NOT NULL,  -- birth_number
    FOREIGN KEY (cityID) REFERENCES City(cityID)
);
CREATE TABLE Disposition (
    dispID INTEGER PRIMARY KEY,
    accountID INTEGER NOT NULL,
    clientID INTEGER NOT NULL,
    dispType TEXT NOT NULL,
    FOREIGN KEY (accountID) REFERENCES Account(accountID),
    FOREIGN KEY (clientID) REFERENCES Client(clientID),
    CHECK (dispType in ('OWNER', 'DISPONENT'))
);
CREATE TABLE CreditCard (
    cardID INTEGER PRIMARY KEY,
    dispID INTEGER NOT NULL,
    cardType TEXT NOT NULL,
    cardIssued TEXT NOT NULL,
    FOREIGN KEY (dispID) REFERENCES Disposition(dispID),
    CHECK (cardType IN ('gold', 'classic', 'junior'))
);
CREATE TABLE City (
    cityID INTEGER PRIMARY KEY,  -- a1
    cityName TEXT,  -- a2
    region TEXT,  -- a3
    inhabitants INTEGER,  -- a4
    muns0 INTEGER,  -- a5
    muns500 INTEGER,  -- a6
    muns2000 INTEGER,  -- a7
    muns10000 INTEGER,  -- a8
    noAreas INTEGER,  -- a9
    ratioUrban REAL,  -- a10
    avgSalary INTEGER,  -- a11
    unemployment1995 REAL,  -- a12
    unemployment1996 REAL,  -- a13
    entrepeneurs INTEGER,  -- a14
    crimes1995 INTEGER,  -- a15
    crimes1996 INTEGER  -- a16
);
