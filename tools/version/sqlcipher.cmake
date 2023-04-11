set(SQLCIPHER_SRC_ROOT ${CMAKE_CURRENT_LIST_DIR}/../../sqlcipher)

# Copy all headers to include folder
file(GLOB SQLCIPHER_PUBLIC_HEADERS
        ${SQLCIPHER_SRC_ROOT}/src/sqlite3_wcdb.h
        ${SQLCIPHER_SRC_ROOT}/sqlite3.h
        ${SQLCIPHER_SRC_ROOT}/ext/fts3/fts3_tokenizer.h
        )
file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include)
file(COPY ${SQLCIPHER_PUBLIC_HEADERS} DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/include/sqlcipher)

file(GLOB SRC_SQLCIPHER
        ${SQLCIPHER_SRC_ROOT}/src/*.c
        )
list(FILTER SRC_SQLCIPHER EXCLUDE REGEX ".*/(test|tcl|crypto|mutex_|os_).*")
list(APPEND SRC_SQLCIPHER
        ${SQLCIPHER_SRC_ROOT}/src/mutex_noop.c
        )

file(GLOB SRC_SQLCIPHER_FTS3
        ${SQLCIPHER_SRC_ROOT}/ext/fts3/*.c
        )
list(FILTER SRC_SQLCIPHER_FTS3 EXCLUDE REGEX ".*_test.c")

file(GLOB SRC_SQLCIPHER_MISC
        ${SQLCIPHER_SRC_ROOT}/parse.c
        ${SQLCIPHER_SRC_ROOT}/opcodes.c
        ${SQLCIPHER_SRC_ROOT}/fts5.c
        ${SQLCIPHER_SRC_ROOT}/ext/rbu/sqlite3rbu.c
        ${SQLCIPHER_SRC_ROOT}/ext/rtree/rtree.c
        ${SQLCIPHER_SRC_ROOT}/ext/userauth/userauth.c
        ${SQLCIPHER_SRC_ROOT}/ext/icu/icu.c
        ${SQLCIPHER_SRC_ROOT}/ext/misc/json1.c
        )

set(ALL_SQLCIPHER_SRCS
        ${SRC_SQLCIPHER}
        ${SRC_SQLCIPHER_FTS3}
        ${SRC_SQLCIPHER_MISC}
        )

add_library(sqlcipher STATIC ${ALL_SQLCIPHER_SRCS})

target_include_directories(sqlcipher PRIVATE
        ${SQLCIPHER_SRC_ROOT}
        ${SQLCIPHER_SRC_ROOT}/src
        ${SQLCIPHER_SRC_ROOT}/ext/fts3
        ${SQLCIPHER_SRC_ROOT}/ext/rbu
        ${SQLCIPHER_SRC_ROOT}/ext/rtree
        ${SQLCIPHER_SRC_ROOT}/ext/userauth
        ${SQLCIPHER_SRC_ROOT}/ext/icu
        )

set(COMPILE_DEFS)

if (ANDROID)
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
else()
    list(APPEND COMPILE_DEFS
            _HAVE_SQLITE_CONFIG_H
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
            SQLITE_DEFAULT_WAL_AUTOCHECKPOINT=0
            SQLITE_DEFAULT_WAL_SYNCHRONOUS=1
            SQLITE_ENABLE_API_ARMOR=1
            SQLITE_ENABLE_BATCH_ATOMIC_WRITE=1
            SQLITE_ENABLE_COLUMN_METADATA=1
            SQLITE_ENABLE_DBSTAT_VTAB=1
            SQLITE_ENABLE_FTS3=1
            SQLITE_ENABLE_FTS3_PARENTHESIS=1
            SQLITE_ENABLE_FTS3_TOKENIZER=1
            SQLITE_ENABLE_FTS5=1
            SQLITE_ENABLE_RTREE=1
            SQLITE_ENABLE_UPDATE_DELETE_LIMIT=1
            SQLITE_HAS_CODEC=1
            SQLITE_LIKE_DOESNT_MATCH_BLOBS=1
            SQLITE_MALLOC_SOFT_LIMIT=0
            SQLITE_MAX_ATTACHED=64
            SQLITE_MAX_EXPR_DEPTH=0
            SQLITE_MAX_SCHEMA_RETRY=50
            SQLITE_MAX_VARIABLE_NUMBER=99
            SQLITE_OMIT_BUILTIN_TEST=1
            SQLITE_OMIT_COMPILEOPTION_DIAGS=1
            SQLITE_OMIT_DEPRECATED=1
            SQLITE_OMIT_LOAD_EXTENSION=1
            SQLITE_OMIT_PROGRESS_CALLBACK=1
            SQLITE_OMIT_SHARED_CACHE=1
            SQLITE_PRINT_BUF_SIZE=256
            SQLITE_SYSTEM_MALLOC=1
            SQLITE_TEMP_STORE=2
            SQLITE_THREADSAFE=2
            SQLITE_UNTESTABLE=1
            SQLITE_USE_ALLOCA=1
            SQLITE_WCDB=1
            SQLITE_WCDB_CHECKPOINT_HANDLER=1
            SQLITE_WCDB_LOCK_HOOK=1
            SQLITE_WCDB_RECOVER_NBACKFILL=1
            SQLITE_WCDB_SUSPEND=1
            USE_PREAD=1
            )
endif ()

if (CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(STATUS "Detected LP64 System, SQLite int64 set to long")
    list(APPEND COMPILE_DEFS SQLITE_INT64_TYPE=long)
endif ()

set(SQLCIPHER_COMPILE_DEFS ${COMPILE_DEFS})

set(SQLCIPHER_SYSTEM_DEFS "")
set(SQLCIPHER_SYSTEM_SRC "")

if (ANDROID OR LINUX)
    list(APPEND SQLCIPHER_SYSTEM_DEFS
            SQLCIPHER_CRYPTO_OPENSSL=1
            SQLITE_OS_UNIX=1)
    list(APPEND SQLCIPHER_SYSTEM_SRC
            ${SQLCIPHER_SRC_ROOT}/src/crypto.c
            ${SQLCIPHER_SRC_ROOT}/src/crypto_impl.c
            ${SQLCIPHER_SRC_ROOT}/src/crypto_openssl.c
            ${SQLCIPHER_SRC_ROOT}/src/mutex_unix.c
            ${SQLCIPHER_SRC_ROOT}/src/os_unix.c)
elseif (WIN32)
    list(APPEND SQLCIPHER_SYSTEM_DEFS
            SQLCIPHER_CRYPTO_OPENSSL=1
            SQLITE_OS_WIN=1)
    list(APPEND SQLCIPHER_SYSTEM_SRC
            ${SQLCIPHER_SRC_ROOT}/src/crypto.c
            ${SQLCIPHER_SRC_ROOT}/src/crypto_impl.c
            ${SQLCIPHER_SRC_ROOT}/src/crypto_openssl.c
            ${SQLCIPHER_SRC_ROOT}/src/mutex_w32.c
            ${SQLCIPHER_SRC_ROOT}/src/os_win.c)
endif ()

target_compile_definitions(sqlcipher PUBLIC
        ${SQLCIPHER_COMPILE_DEFS})
target_compile_definitions(sqlcipher PRIVATE
        ${SQLCIPHER_SYSTEM_DEFS})

target_sources(sqlcipher PRIVATE
        ${SQLCIPHER_SYSTEM_SRC})

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_definitions(sqlcipher PRIVATE
            SQLITE_DEBUG
            )
else ()
    target_compile_definitions(sqlcipher PRIVATE
            NDEBUG
            )
endif ()
