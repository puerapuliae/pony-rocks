use @rocksdb_options_create[Options]()

use @rocksdb_options_set_create_if_missing[None](options: Options, flag: Bool)

use @rocksdb_open[RocksDBPointer](options: Options, name: BytePointerTag, err: StringPointerRef)
use @rocksdb_open_for_read_only[RocksDBPointer](options: Options, name: BytePointerTag, errorIfLogFileExists: Bool, err: StringPointerRef)

use @rocksdb_writeoptions_create[WriteOptions]()

use @rocksdb_put[None](db: RocksDBPointer, writeOptions: WriteOptions, key: BytePointerTag, keySize: USize, value: BytePointerTag, valueSize: USize, err: StringPointerRef)

use @rocksdb_readoptions_create[ReadOptions]()

use @rocksdb_get[BytePointerRef](db: RocksDBPointer, readOptions: ReadOptions, key: BytePointerTag, keySize: USize, length: USizePointerRef, err: StringPointerRef)

use @free[None](pointer: BytePointerRef)

use @rocksdb_writeoptions_destroy[None](writeOptions: WriteOptions)

use @rocksdb_readoptions_destroy[None](readOptions: ReadOptions)

use @rocksdb_options_destroy[None](options: Options)

use @rocksdb_close[None](db: RocksDBPointer)

use @rocksdb_open_column_families[RocksDBPointer](options: Options, name: BytePointerTag, numberOfColumnFamilies: USize, columnFamilyNames: StringPointerRef, columnFamilyOptions: OptionsRef, columnFamilyHandles: ColumnFamilyHandle)

use @rocksdb_create_column_family[ColumnFamilyHandle](db: RocksDBPointer, options: Options, columnFamilyName: BytePointerTag, err: StringPointerRef)

use @rocksdb_column_family_handle_destroy[None](columnFamilyHandle: ColumnFamilyHandle)

primitive _RocksDB
primitive _Options
primitive _WriteOptions
primitive _ReadOptions
primitive _Len
primitive _ColumnFamilyHandle

type Options is Pointer[_Options] box
type OptionsRef is Pointer[_Options] ref
type WriteOptions is Pointer[_WriteOptions] box
type ReadOptions is Pointer[_ReadOptions] box
type RocksDBPointer is Pointer[_RocksDB] val
type ColumnFamilyHandle is Pointer[_ColumnFamilyHandle] ref

type BytePointerRef is Pointer[U8 val] ref
type BytePointerTag is Pointer[U8 val] tag
type StringPointerRef is Pointer[String val] ref
type USizePointerRef is Pointer[USize val] ref
