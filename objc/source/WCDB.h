/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef WCDB_h
#define WCDB_h

#ifndef __cplusplus
#error Since WCDB is an Objective-C++ framework, for those files in your project that includes WCDB, you should rename their extension `.m` to `.mm`.
#endif

/* TODO list:
 * check OOM
 * replace assert with our own function with log
 * add authorize to avoid writing on the migration database
 * -Wglobal-constructors
 * remove redundant `virtual`
 * async migration
 * multi-migration
 * fix other TODOs
 * fix template installtion
 * add nonnull, nullable
 * add comment
 * customlize FTS tokenize name
 * performance opti
 * add column coding header to template
 */

#import <WCDB/Abstract.h>
#import <WCDB/Core.h>
#import <WCDB/Interface.h>

#endif /* WCDB_h */
