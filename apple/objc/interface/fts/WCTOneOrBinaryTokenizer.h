//
// Created by qiuwenchen on 2021/11/8.
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

#import <WCDB/TokenizerModuleTemplate.hpp>
#import <WCDB/WCTFTSTokenizerUtil.h>
#import <vector>

class WCTOneOrBinaryTokenizerInfo final : public WCDB::AbstractFTS3TokenizerInfo {
public:
    WCTOneOrBinaryTokenizerInfo(int argc, const char *const *argv);
    ~WCTOneOrBinaryTokenizerInfo() override final;
    bool m_needSymbol;
    bool m_needSimplifiedChinese;
    bool m_skipStemming;
};

class WCTOneOrBinaryTokenizer final : public WCDB::AbstractFTS3TokenizerCursorInfo,
                                      public WCDB::AbstractFTS5Tokenizer {
public:
    //for fts3/fts4
    WCTOneOrBinaryTokenizer(const char *input,
                            int inputLength,
                            WCDB::AbstractFTS3TokenizerInfo *tokenizerInfo);
    ~WCTOneOrBinaryTokenizer() override;
    int step(const char **ppToken,
             int *pnBytes,
             int *piStartOffset,
             int *piEndOffset,
             int *piPosition) override final;

    //for fts5
    WCTOneOrBinaryTokenizer(void *pCtx, const char **azArg, int nArg);
    void loadInput(int flags, const char *pText, int nText) override;
    int nextToken(int *tflags, const char **ppToken, int *nToken, int *iStart, int *iEnd) override;

    int stepNextToken();

private:
    const char *m_input;
    int m_inputLength;

    int m_position;
    int m_startOffset;
    int m_endOffset;

    int m_cursor;
    int m_cursorTokenLength;

    using UnicodeType = WCTFTSTokenizerUtil::UnicodeType;
    UnicodeType m_cursorTokenType;
    UnicodeType m_preTokenType;

    std::vector<int> m_subTokensLengthArray;
    int m_subTokensCursor;
    bool m_subTokensDoubleChar;

    std::vector<char> m_token;
    int m_tokenLength;

    bool m_needBinary;
    // Can be configed by tokenizer parameters
    bool m_needSymbol;
    bool m_needSimplifiedChinese;
    bool m_skipStemming;

    int cursorStep();
    void subTokensStep();

    void lemmatization(const char *input, int inputLength);
    void genToken();
};
