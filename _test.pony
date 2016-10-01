use "ponytest"

actor Main is TestList

  new create(env: Env) =>
    PonyTest(env, this)

  new make() => None

  fun tag tests(test: PonyTest) =>
    test(_CreateDatabase)

class _BehaviourResult

  fun tag fulfill(h: TestHelper, expected: String, actual: String): String =>
    h.assert_eq[String](expected, actual)
    h.complete(true)
    actual

class iso _CreateDatabase is UnitTest

  fun name(): String => "Create a database"

  fun apply(h: TestHelper) =>
    h.long_test(1_000_000_000)

    RocksDB.open(Path("testdb"))
      .put("key", "value")
      .put("key2", "value2")
      .get("key2").next[String](recover _BehaviourResult~fulfill(h, "value2") end)
