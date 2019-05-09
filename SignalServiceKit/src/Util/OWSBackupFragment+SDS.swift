//
//  Copyright (c) 2019 Open Whisper Systems. All rights reserved.
//

import Foundation
import GRDBCipher
import SignalCoreKit

// NOTE: This file is generated by /Scripts/sds_codegen/sds_generate.py.
// Do not manually edit it, instead run `sds_codegen.sh`.

// MARK: - Record

public struct BackupFragmentRecord: Codable, FetchableRecord, PersistableRecord, TableRecord {
    public static let databaseTableName: String = OWSBackupFragmentSerializer.table.tableName

    public let id: UInt64

    // This defines all of the columns used in the table
    // where this model (and any subclasses) are persisted.
    public let recordType: SDSRecordType
    public let uniqueId: String

    // Base class properties
    public let attachmentId: String?
    public let downloadFilePath: String?
    public let encryptionKey: Data
    public let recordName: String
    public let relativeFilePath: String?
    public let uncompressedDataLength: UInt64?

    public enum CodingKeys: String, CodingKey, ColumnExpression, CaseIterable {
        case id
        case recordType
        case uniqueId
        case attachmentId
        case downloadFilePath
        case encryptionKey
        case recordName
        case relativeFilePath
        case uncompressedDataLength
    }

    public static func columnName(_ column: BackupFragmentRecord.CodingKeys) -> String {
        return column.rawValue
    }

}

// MARK: - StringInterpolation

public extension String.StringInterpolation {
    mutating func appendInterpolation(columnForBackupFragment column: BackupFragmentRecord.CodingKeys) {
        appendLiteral(BackupFragmentRecord.columnName(column))
    }
}

// MARK: - Deserialization

// TODO: Remove the other Deserialization extension.
// TODO: SDSDeserializer.
// TODO: Rework metadata to not include, for example, columns, column indices.
extension OWSBackupFragment {
    // This method defines how to deserialize a model, given a
    // database row.  The recordType column is used to determine
    // the corresponding model class.
    class func fromRecord(_ record: BackupFragmentRecord) throws -> OWSBackupFragment {

        switch record.recordType {
        case .backupFragment:

            let uniqueId: String = record.uniqueId
            let sortId: UInt64 = record.id
            let attachmentId: String? = SDSDeserialization.optionalString(record.attachmentId, name: "attachmentId")
            let downloadFilePath: String? = SDSDeserialization.optionalString(record.downloadFilePath, name: "downloadFilePath")
            let encryptionKey: Data = record.encryptionKey
            let recordName: String = record.recordName
            let relativeFilePath: String? = SDSDeserialization.optionalString(record.relativeFilePath, name: "relativeFilePath")
            let uncompressedDataLength: NSNumber? = SDSDeserialization.optionalNumericAsNSNumber(record.uncompressedDataLength, name: "uncompressedDataLength", conversion: { NSNumber(value: $0) })

            return OWSBackupFragment(uniqueId: uniqueId,
                                     attachmentId: attachmentId,
                                     downloadFilePath: downloadFilePath,
                                     encryptionKey: encryptionKey,
                                     recordName: recordName,
                                     relativeFilePath: relativeFilePath,
                                     uncompressedDataLength: uncompressedDataLength)

        default:
            owsFailDebug("Unexpected record type: \(record.recordType)")
            throw SDSError.invalidValue
        }
    }
}

// MARK: - SDSSerializable

extension OWSBackupFragment: SDSSerializable {
    public var serializer: SDSSerializer {
        // Any subclass can be cast to it's superclass,
        // so the order of this switch statement matters.
        // We need to do a "depth first" search by type.
        switch self {
        default:
            return OWSBackupFragmentSerializer(model: self)
        }
    }
}

// MARK: - Table Metadata

extension OWSBackupFragmentSerializer {

    // This defines all of the columns used in the table
    // where this model (and any subclasses) are persisted.
    static let recordTypeColumn = SDSColumnMetadata(columnName: "recordType", columnType: .int, columnIndex: 0)
    static let idColumn = SDSColumnMetadata(columnName: "id", columnType: .primaryKey, columnIndex: 1)
    static let uniqueIdColumn = SDSColumnMetadata(columnName: "uniqueId", columnType: .unicodeString, columnIndex: 2)
    // Base class properties
    static let attachmentIdColumn = SDSColumnMetadata(columnName: "attachmentId", columnType: .unicodeString, isOptional: true, columnIndex: 3)
    static let downloadFilePathColumn = SDSColumnMetadata(columnName: "downloadFilePath", columnType: .unicodeString, isOptional: true, columnIndex: 4)
    static let encryptionKeyColumn = SDSColumnMetadata(columnName: "encryptionKey", columnType: .blob, columnIndex: 5)
    static let recordNameColumn = SDSColumnMetadata(columnName: "recordName", columnType: .unicodeString, columnIndex: 6)
    static let relativeFilePathColumn = SDSColumnMetadata(columnName: "relativeFilePath", columnType: .unicodeString, isOptional: true, columnIndex: 7)
    static let uncompressedDataLengthColumn = SDSColumnMetadata(columnName: "uncompressedDataLength", columnType: .int64, isOptional: true, columnIndex: 8)

    // TODO: We should decide on a naming convention for
    //       tables that store models.
    public static let table = SDSTableMetadata(tableName: "model_OWSBackupFragment", columns: [
        recordTypeColumn,
        idColumn,
        uniqueIdColumn,
        attachmentIdColumn,
        downloadFilePathColumn,
        encryptionKeyColumn,
        recordNameColumn,
        relativeFilePathColumn,
        uncompressedDataLengthColumn
        ])

}

// MARK: - Deserialization

extension OWSBackupFragmentSerializer {
    // This method defines how to deserialize a model, given a
    // database row.  The recordType column is used to determine
    // the corresponding model class.
    class func sdsDeserialize(statement: SelectStatement) throws -> OWSBackupFragment {

        if OWSIsDebugBuild() {
            guard statement.columnNames == table.selectColumnNames else {
                owsFailDebug("Unexpected columns: \(statement.columnNames) != \(table.selectColumnNames)")
                throw SDSError.invalidResult
            }
        }

        // SDSDeserializer is used to convert column values into Swift values.
        let deserializer = SDSDeserializer(sqliteStatement: statement.sqliteStatement)
        let recordTypeValue = try deserializer.int(at: 0)
        guard let recordType = SDSRecordType(rawValue: UInt(recordTypeValue)) else {
            owsFailDebug("Invalid recordType: \(recordTypeValue)")
            throw SDSError.invalidResult
        }
        switch recordType {
        case .backupFragment:

            let uniqueId = try deserializer.string(at: uniqueIdColumn.columnIndex)
            let attachmentId = try deserializer.optionalString(at: attachmentIdColumn.columnIndex)
            let downloadFilePath = try deserializer.optionalString(at: downloadFilePathColumn.columnIndex)
            let encryptionKey = try deserializer.blob(at: encryptionKeyColumn.columnIndex)
            let recordName = try deserializer.string(at: recordNameColumn.columnIndex)
            let relativeFilePath = try deserializer.optionalString(at: relativeFilePathColumn.columnIndex)
            let uncompressedDataLength = try deserializer.optionalUInt64AsNSNumber(at: uncompressedDataLengthColumn.columnIndex)

            return OWSBackupFragment(uniqueId: uniqueId,
                                     attachmentId: attachmentId,
                                     downloadFilePath: downloadFilePath,
                                     encryptionKey: encryptionKey,
                                     recordName: recordName,
                                     relativeFilePath: relativeFilePath,
                                     uncompressedDataLength: uncompressedDataLength)

        default:
            owsFail("Invalid record type \(recordType)")
        }
    }
}

// MARK: - Save/Remove/Update

@objc
extension OWSBackupFragment {
    public func anySave(transaction: SDSAnyWriteTransaction) {
        switch transaction.writeTransaction {
        case .yapWrite(let ydbTransaction):
            save(with: ydbTransaction)
        case .grdbWrite(let grdbTransaction):
            SDSSerialization.save(entity: self, transaction: grdbTransaction)
        }
    }

    // This method is used by "updateWith..." methods.
    //
    // This model may be updated from many threads. We don't want to save
    // our local copy (this instance) since it may be out of date.  We also
    // want to avoid re-saving a model that has been deleted.  Therefore, we
    // use "updateWith..." methods to:
    //
    // a) Update a property of this instance.
    // b) If a copy of this model exists in the database, load an up-to-date copy,
    //    and update and save that copy.
    // b) If a copy of this model _DOES NOT_ exist in the database, do _NOT_ save
    //    this local instance.
    //
    // After "updateWith...":
    //
    // a) Any copy of this model in the database will have been updated.
    // b) The local property on this instance will always have been updated.
    // c) Other properties on this instance may be out of date.
    //
    // All mutable properties of this class have been made read-only to
    // prevent accidentally modifying them directly.
    //
    // This isn't a perfect arrangement, but in practice this will prevent
    // data loss and will resolve all known issues.
    public func anyUpdateWith(transaction: SDSAnyWriteTransaction, block: (OWSBackupFragment) -> Void) {
        guard let uniqueId = uniqueId else {
            owsFailDebug("Missing uniqueId.")
            return
        }

        guard let dbCopy = type(of: self).anyFetch(uniqueId: uniqueId,
                                                   transaction: transaction) else {
            return
        }

        block(self)
        block(dbCopy)

        dbCopy.anySave(transaction: transaction)
    }

    public func anyRemove(transaction: SDSAnyWriteTransaction) {
        switch transaction.writeTransaction {
        case .yapWrite(let ydbTransaction):
            remove(with: ydbTransaction)
        case .grdbWrite(let grdbTransaction):
            SDSSerialization.delete(entity: self, transaction: grdbTransaction)
        }
    }
}

// MARK: - OWSBackupFragmentCursor

@objc
public class OWSBackupFragmentCursor: NSObject {
    private let cursor: SDSCursor<OWSBackupFragment>

    init(cursor: SDSCursor<OWSBackupFragment>) {
        self.cursor = cursor
    }

    // TODO: Revisit error handling in this class.
    public func next() throws -> OWSBackupFragment? {
        return try cursor.next()
    }

    public func all() throws -> [OWSBackupFragment] {
        return try cursor.all()
    }
}

// MARK: - Obj-C Fetch

// TODO: We may eventually want to define some combination of:
//
// * fetchCursor, fetchOne, fetchAll, etc. (ala GRDB)
// * Optional "where clause" parameters for filtering.
// * Async flavors with completions.
//
// TODO: I've defined flavors that take a read transaction.
//       Or we might take a "connection" if we end up having that class.
@objc
extension OWSBackupFragment {
    public class func grdbFetchCursor(transaction: GRDBReadTransaction) -> OWSBackupFragmentCursor {
        return OWSBackupFragmentCursor(cursor: SDSSerialization.fetchCursor(tableMetadata: OWSBackupFragmentSerializer.table,
                                                                   transaction: transaction,
                                                                   deserialize: OWSBackupFragmentSerializer.sdsDeserialize))
    }

    // Fetches a single model by "unique id".
    public class func anyFetch(uniqueId: String,
                               transaction: SDSAnyReadTransaction) -> OWSBackupFragment? {
        assert(uniqueId.count > 0)

        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            return OWSBackupFragment.fetch(uniqueId: uniqueId, transaction: ydbTransaction)
        case .grdbRead(let grdbTransaction):
            let tableMetadata = OWSBackupFragmentSerializer.table
            let columnNames: [String] = tableMetadata.selectColumnNames
            let columnsSQL: String = columnNames.map { $0.quotedDatabaseIdentifier }.joined(separator: ", ")
            let tableName: String = tableMetadata.tableName
            let uniqueIdColumnName: String = OWSBackupFragmentSerializer.uniqueIdColumn.columnName
            let sql: String = "SELECT \(columnsSQL) FROM \(tableName.quotedDatabaseIdentifier) WHERE \(uniqueIdColumnName.quotedDatabaseIdentifier) == ?"

            let cursor = OWSBackupFragment.grdbFetchCursor(sql: sql,
                                                  arguments: [uniqueId],
                                                  transaction: grdbTransaction)
            do {
                return try cursor.next()
            } catch {
                owsFailDebug("error: \(error)")
                return nil
            }
        }
    }

    // Traverses all records.
    // Records are not visited in any particular order.
    // Traversal aborts if the visitor returns false.
    public class func anyVisitAll(transaction: SDSAnyReadTransaction, visitor: @escaping (OWSBackupFragment) -> Bool) {
        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            OWSBackupFragment.enumerateCollectionObjects(with: ydbTransaction) { (object, stop) in
                guard let value = object as? OWSBackupFragment else {
                    owsFailDebug("unexpected object: \(type(of: object))")
                    return
                }
                guard visitor(value) else {
                    stop.pointee = true
                    return
                }
            }
        case .grdbRead(let grdbTransaction):
            do {
                let cursor = OWSBackupFragment.grdbFetchCursor(transaction: grdbTransaction)
                while let value = try cursor.next() {
                    guard visitor(value) else {
                        return
                    }
                }
            } catch let error as NSError {
                owsFailDebug("Couldn't fetch models: \(error)")
            }
        }
    }

    // Does not order the results.
    public class func anyFetchAll(transaction: SDSAnyReadTransaction) -> [OWSBackupFragment] {
        var result = [OWSBackupFragment]()
        anyVisitAll(transaction: transaction) { (model) in
            result.append(model)
            return true
        }
        return result
    }
}

// MARK: - Swift Fetch

extension OWSBackupFragment {
    public class func grdbFetchCursor(sql: String,
                                      arguments: [DatabaseValueConvertible]?,
                                      transaction: GRDBReadTransaction) -> OWSBackupFragmentCursor {
        var statementArguments: StatementArguments?
        if let arguments = arguments {
            guard let statementArgs = StatementArguments(arguments) else {
                owsFail("Could not convert arguments.")
            }
            statementArguments = statementArgs
        }
        return OWSBackupFragmentCursor(cursor: SDSSerialization.fetchCursor(sql: sql,
                                                             arguments: statementArguments,
                                                             transaction: transaction,
                                                                   deserialize: OWSBackupFragmentSerializer.sdsDeserialize))
    }
}

// MARK: - SDSSerializer

// The SDSSerializer protocol specifies how to insert and update the
// row that corresponds to this model.
class OWSBackupFragmentSerializer: SDSSerializer {

    private let model: OWSBackupFragment
    public required init(model: OWSBackupFragment) {
        self.model = model
    }

    public func serializableColumnTableMetadata() -> SDSTableMetadata {
        return OWSBackupFragmentSerializer.table
    }

    public func insertColumnNames() -> [String] {
        // When we insert a new row, we include the following columns:
        //
        // * "record type"
        // * "unique id"
        // * ...all columns that we set when updating.
        return [
            OWSBackupFragmentSerializer.recordTypeColumn.columnName,
            uniqueIdColumnName()
            ] + updateColumnNames()

    }

    public func insertColumnValues() -> [DatabaseValueConvertible] {
        let result: [DatabaseValueConvertible] = [
            SDSRecordType.backupFragment.rawValue
            ] + [uniqueIdColumnValue()] + updateColumnValues()
        if OWSIsDebugBuild() {
            if result.count != insertColumnNames().count {
                owsFailDebug("Update mismatch: \(result.count) != \(insertColumnNames().count)")
            }
        }
        return result
    }

    public func updateColumnNames() -> [String] {
        return [
            OWSBackupFragmentSerializer.attachmentIdColumn,
            OWSBackupFragmentSerializer.downloadFilePathColumn,
            OWSBackupFragmentSerializer.encryptionKeyColumn,
            OWSBackupFragmentSerializer.recordNameColumn,
            OWSBackupFragmentSerializer.relativeFilePathColumn,
            OWSBackupFragmentSerializer.uncompressedDataLengthColumn
            ].map { $0.columnName }
    }

    public func updateColumnValues() -> [DatabaseValueConvertible] {
        let result: [DatabaseValueConvertible] = [
            self.model.attachmentId ?? DatabaseValue.null,
            self.model.downloadFilePath ?? DatabaseValue.null,
            self.model.encryptionKey,
            self.model.recordName,
            self.model.relativeFilePath ?? DatabaseValue.null,
            self.model.uncompressedDataLength ?? DatabaseValue.null

        ]
        if OWSIsDebugBuild() {
            if result.count != updateColumnNames().count {
                owsFailDebug("Update mismatch: \(result.count) != \(updateColumnNames().count)")
            }
        }
        return result
    }

    public func uniqueIdColumnName() -> String {
        return OWSBackupFragmentSerializer.uniqueIdColumn.columnName
    }

    // TODO: uniqueId is currently an optional on our models.
    //       We should probably make the return type here String?
    public func uniqueIdColumnValue() -> DatabaseValueConvertible {
        // FIXME remove force unwrap
        return model.uniqueId!
    }
}
