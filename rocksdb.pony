use "lib:rocksdb"
use "promises"

class val Path
  let _path: String

  new val create(path: String) =>
    _path = path

  fun _get(): Pointer[U8 val] tag =>
    _path.cstring()

actor _Reader
  let _options: Options
  let _readOnlyConnection: RocksDBPointer
  let _readOptions: ReadOptions

  new create(path: Path) =>
    var err: String = ""
    _options = @rocksdb_options_create()
    @rocksdb_options_set_create_if_missing(_options, true)

    _readOnlyConnection = @rocksdb_open_for_read_only(_options, path._get(), false, addressof err)
    _readOptions = @rocksdb_readoptions_create()

  be _get(key: String, p: Promise[String]) =>
    var err: String = ""
    var valueLength: USize = 0
    let result = @rocksdb_get(_readOnlyConnection, _readOptions, key.cstring(), key.size(), addressof valueLength, addressof err)

    p(String.from_cstring(result, valueLength, valueLength).string())

  fun _final() =>
    if not _readOptions.is_null() then
      @rocksdb_readoptions_destroy(_readOptions)
    end
 
    if not _readOnlyConnection.is_null() then
      @rocksdb_close(_readOnlyConnection)
    end


actor RocksDB
  let _options: Options
  let _writeConnection: RocksDBPointer
  let _writeOptions: WriteOptions
  let _reader: _Reader

  new open(path: Path) =>
    var err: String = ""
    _options = @rocksdb_options_create()
    @rocksdb_options_set_create_if_missing(_options, true)

    _writeConnection = @rocksdb_open(_options, path._get(), addressof err)
    _writeOptions = @rocksdb_writeoptions_create()

    _reader = _Reader(path)

  be put(key: String, value: String) =>
    let test = "test"
     var err: String = ""
    @rocksdb_put(_writeConnection, _writeOptions, key.cstring(), key.size(), value.cstring(), value.size(), addressof err)

  be _get(key: String, p: Promise[String]) =>
    _reader._get(key, p)

  fun tag get(key: String): Promise[String] =>
    let p = Promise[String]
    _get(key, p)
    p

  fun _final() =>
    if not _options.is_null() then
      @rocksdb_options_destroy(_options)
    end

    if not _writeOptions.is_null() then
      @rocksdb_writeoptions_destroy(_writeOptions)
    end

    if not _writeConnection.is_null() then
      @rocksdb_close(_writeConnection)
    end
