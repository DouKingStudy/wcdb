//
// Created by qiuwenchen on 2022/8/26.
//

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

#pragma once

#include <WCDB/CPPDeclaration.h>
#include <WCDB/MemberPointer.hpp>

namespace WCDB {

#pragma mark - Field

class Field final : public Column {
public:
    Field() = delete;
    Field(const UnsafeStringView& name, const std::shared_ptr<BaseAccessor> accessor);
    ~Field() override final;

    template<class ORMType, typename FieldType>
    Field(FieldType ORMType::*memberPointer)
    {
        static_assert(ORMType::isObjectRelationMapped, "This class has no ORM configuration.");
        static_assert(IsFieldMemberPointer<FieldType ORMType::*>::value,
                      "Field should be initialize with a member field pointer, not a member function pointer");

        void* voidPointer = castMemberPointer(memberPointer);
        const Binding& binding = ORMType::getObjectRelationBinding();
        configWithBinding(binding, voidPointer);
    }

    Column table(const UnsafeStringView& table) const;

    std::shared_ptr<BaseAccessor> getAccessor() const;

private:
    void configWithBinding(const Binding& binding, void* memberPointer);
    std::shared_ptr<BaseAccessor> m_accessor;
};

#pragma mark - Fields

template<>
class SyntaxList<Field> final : public _SyntaxList<Field> {
public:
    using _SyntaxList<Field>::_SyntaxList;
    ~SyntaxList() override final;

    ResultFields redirect(const ResultColumns& resultColumns) const;

    typedef ResultColumn (^RedirectBlock)(const Field&);
    ResultFields redirect(RedirectBlock block) const;

    // It's not the count of the list, but the SQL function `count(*)`.
    Expression count() const;

    Expressions table(const StringView& table) const;

    Fields fieldsByAddingNewFields(const Fields& fields) const;
    Fields& addingNewFields(const Fields& fields);

    Fields fieldsByRemovingFields(const Fields& fields) const;
    Fields& removingFields(const Fields& fields);

private:
    static bool isEqual(const Field& left, const Field& right);
};

#pragma mark - Convertible

template<>
class ExpressionConvertible<Field> final : public std::true_type {
public:
    static Expression asExpression(const Field& field);
};

template<>
class IndexedColumnConvertible<Field> final : public std::true_type {
public:
    static IndexedColumn asIndexedColumn(const Field& field);
};

} //namespace WCDB
