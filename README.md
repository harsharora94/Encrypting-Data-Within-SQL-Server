# Encrypting Data Within SQL Server 

### Data Anonymization:
It is a type of information sanitization whose intent is privacy protection. It is the process of either encrypting or removing personally identifiable information from data sets, so that the people whom the data describe remains anonymous.

### Types of Encryption:

1. Transparent Data Encryption (TDE)
2. Cell Level Encryption
3. Always Encrypted

### Encryption in SQL Server - TDE

Transparent Data Encryption (TDE) is concept of encrypting data and log files of a database. This encryption is transparent to user, as data gets stored in encrypted format on disks and when user retrieves the data it gets decrypted and shown. 

For more information related to TDE can be found in below links: 

[Transparent Data Encryption (TDE)- Link 1](https://docs.microsoft.com/en-us/previous-versions/sql/sql-server-2008-r2/bb934049(v=sql.105)?redirectedfrom=MSDN)

[Transparent Data Encryption (TDE)- Link 2](https://www.red-gate.com/simple-talk/sql/database-administration/transparent-data-encryption/)

It comes under Data at Rest security feature at SQL Server level. Microsoft provides it with only Enterprise Edition of SQL Server. There is no application change required while encrypting SQL Server data files using TDE. 
Under this feature, following are the data files which can be securely encrypted:
1. SQL Server Log
2. Files
3. SQL Backups

### Encryption in SQL Server - Cell Level

It was introduced from SQL Server 2005 version onwards. Microsoft provides it with only Enterprise Edition of SQL Server. There is an application change required while encrypting SQL Server at cell level. 

### Encryption in SQL Server - Always Encrypted

Always Encrypted with secure enclaves provides additional functionality to the Always Encrypted feature.
It is introduced in SQL Server 2016, Always Encrypted protects the confidentiality of sensitive data from malware and high-privileged unauthorized users of SQL Server. High-privileged unauthorized users are DBAs, computer admins, cloud admins, or anyone else who has legitimate access to server instances, hardware, etc., but who should not have access to some or all of the actual data.
Microsoft provides it with Enterprise & Standard Edition of SQL Server 2016. It can be applied at the client side from .NET 4.6 framework onwards.

### Always Encrypted:

1. SSL Encrypted 
2. Data Encrypted in Memory
3. No DML without permissions. Missing 
4. Missing .NET 4.6 Frameowrk returns varbinary field type
5. Correct setups returns field type

### Securing Always Encrypted:
  #### Column Master Key:
  1. Protects column encryption keys.
  2. Stored in a trusted key store.
  3. System catalog views.
  4. View in SSMS.
  5. Windows Certificate Store
     <ol>
     <li>Current User
     <li>Local Machine
     </ol>
  
  #### Column Encryption Key:
  1. Protected by Column Master Key.
  2. Encrypts sensitive column data.
  3. Column encrypted with single column encryption key.
  4. System catalog views.
  5. Backup keys.

### Enclave-enabled Columns

An enclave-enabled column is a database column encrypted with an enclave-enabled column encryption key. The functionality available for an enclave-enabled column depends on the encryption type the column is using.
1. Deterministic encryption - Enclave-enabled columns using deterministic encryption support in-place encryption, but no other operations inside the secure enclave. Equality comparison is supported, but it is performed by comparing the ciphertext outside of the enclave.
2. Randomized encryption - Enclave-enabled columns using randomized encryption support in-place encryption as well as rich computations inside the secure enclave. The supported rich computations are pattern matching and comparison operators, including equality comparison.

### Always Encrypted - Flow Diagram

Always Encrypted uses secure enclaves as illustrated in the following diagram:

![AlwaysEncrypted-FlowDiagram](/images/AlwaysEncrypted-Flowchart.png)
When parsing an application's query, the SQL Server Engine determines if the query contains any operations on encrypted data that require the use of the secure enclave. For queries where the secure enclave needs to be accessed:
  1. The client driver sends the column encryption keys required for the operations to the secure enclave (over a secure channel).
  2. Then, the client driver submits the query for execution along with the encrypted query parameters.

During query processing, the data or the column encryption keys are not exposed in plaintext in the SQL Server Engine outside of the secure enclave. The SQL Server Engine delegates cryptographic operations and computations on encrypted columns to the secure enclave. If needed, the secure enclave decrypts the query parameters and/or the data stored in encrypted columns and performs the requested operations.

The following table summarizes the functionality available for encrypted columns, depending on whether the columns use enclave-enabled column encryption keys and an encryption type:

![AlwaysEncrypted-2019](/images/Always_Encrypted_2019.png)

In-place encryption includes support for the following operations inside the enclave:

1. Initial encryption of data stored in an existing column.
2. Re-encrypting existing data in a column, for example:
   <ol>
    <li>Rotating the column encryption key (re-encrypting the column with a new key).
    <li>Changing the encryption type.
  </ol>

3. Decrypting data stored in an encrypted column (converting the column into a plaintext column).

For in-place encryption to be possible, the column encryption key (or keys), involved in the cryptographic operations, must be enclave-enabled:

1. Initial encryption: the column encryption key for the column being encrypted must be enclave-enabled.
2. Re-encryption: both the current and the target column encryption key (if different than the current key) must be enclave-enabled.
3. Decryption: the current column encryption key of the column must be enclave-enabled

[Supported Reference Link For Always Encrypted Enclaves](https://docs.microsoft.com/en-us/sql/relational-databases/security/encryption/always-encrypted-enclaves?view=sqlallproducts-allversions)
