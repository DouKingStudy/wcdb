set(SQLCIPHER_ANDROID_LIB_PATH)

wconan_get_libraries_dir(SQLCIPHER_ANDROID_LIB_PATH android_sqlcipher)

message(STATUS "SQLCIPHER_ANDROID_LIB_PATH: ${SQLCIPHER_ANDROID_LIB_PATH}/include")

target_include_directories(${TARGET_NAME} PRIVATE
        ${SQLCIPHER_ANDROID_LIB_PATH}/include)

target_link_directories(${TARGET_NAME} PRIVATE
        ${SQLCIPHER_ANDROID_LIB_PATH}/libs)

set(LIB_SQLCIPHER libwcdb.so)

set(COMPILE_DEFS "")
list(APPEND COMPILE_DEFS
        HAVE_USLEEP=1
        OMIT_MEM_SECURITY=1
        OMIT_MEMLOCK=1
        SQLCIPHER_PREPROCESSED=1
        SQLITE_CORE=1
        SQLITE_DEFAULT_CACHE_SIZE=-2000
        SQLITE_DEFAULT_JOURNAL_SIZE_LIMIT=4194304
        SQLITE_DEFAULT_LOCKING_MODE=0
        SQLITE_DEFAULT_MEMSTATUS=0
        SQLITE_DEFAULT_PAGE_SIZE=4096
        SQLITE_DEFAULT_SYNCHRONOUS=1
        SQLITE_DEFAULT_WAL_AUTOCHECKPOINT=100
        SQLITE_DEFAULT_WAL_SYNCHRONOUS=1
        SQLITE_ENABLE_COLUMN_METADATA=1
        SQLITE_ENABLE_DBSTAT_VTAB=1
        SQLITE_ENABLE_FTS3=1
        SQLITE_ENABLE_FTS3_PARENTHESIS=1
        SQLITE_ENABLE_FTS3_TOKENIZER=1
        SQLITE_ENABLE_FTS5=1
        SQLITE_ENABLE_JSON1=1
        SQLITE_ENABLE_MEMORY_MANAGEMENT=1
        SQLITE_ENABLE_PREUPDATE_HOOK=1
        SQLITE_ENABLE_RTREE=1
        SQLITE_ENABLE_SESSION=1
        SQLITE_ENABLE_STAT4=1
        SQLITE_ENABLE_UPDATE_DELETE_LIMIT=1
        SQLITE_HAS_CODEC=1
        SQLITE_HAVE_ISNAN=1
        SQLITE_LIKE_DOESNT_MATCH_BLOBS=1
        SQLITE_MALLOC_SOFT_LIMIT=0
        SQLITE_MAX_ATTACHED=64
        SQLITE_MAX_EXPR_DEPTH=0
        SQLITE_MAX_SCHEMA_RETRY=50
        SQLITE_MAX_VARIABLE_NUMBER=99
        SQLITE_OMIT_BUILTIN_TEST=1
        SQLITE_OMIT_COMPILEOPTION_DIAGS=1
        SQLITE_OMIT_DEPRECATED=1
        SQLITE_PRINT_BUF_SIZE=256
        SQLITE_SYSTEM_MALLOC=1
        SQLITE_TEMP_STORE=2
        SQLITE_THREADSAFE=2
        SQLITE_UNTESTABLE=1
        SQLITE_WCDB=1
        SQLITE_WCDB_CHECKPOINT_HANDLER=1
        SQLITE_WCDB_IMPROVED_CHECKPOINT=1
        SQLITE_WCDB_LOCK_HOOK=1
        SQLITE_WCDB_SUSPEND=1
        USE_PREAD64=1
        )

if (CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(STATUS "Detected LP64 System, SQLite int64 set to long")
    list(APPEND COMPILE_DEFS SQLITE_INT64_TYPE=long)
endif ()

set(SQLCIPHER_COMPILE_DEFS ${COMPILE_DEFS})

target_compile_definitions(${TARGET_NAME} PRIVATE
        ${SQLCIPHER_COMPILE_DEFS})