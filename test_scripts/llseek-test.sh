#!/bin/bash

TEST_FILE=/dev/aesdchar
INITIAL_CONTENT="ABCDEFGHIJKLMNOPQRSTUVWXYZ" # 26 bytes
OVERWRITE_CONTENT="12345" # 5 bytes
OFFSET=10 # 从第10个字节开始覆盖 (0-indexed)

echo "--- Shell Script Lseek Test ---"

# 1. 清理旧的测试文件
if [ -f "$TEST_FILE" ]; then
    rm "$TEST_FILE"
    echo "Removed existing $TEST_FILE"
fi

# 2. 写入初始内容
echo -n "$INITIAL_CONTENT" > "$TEST_FILE"
echo "Initial content written to $TEST_FILE: \"$INITIAL_CONTENT\""
echo "File size: $(stat -c%s "$TEST_FILE") bytes" # 确保文件大小正确

# 3. 使用 dd 进行带偏移的写入 (模拟 lseek + write)
echo "Overwriting at offset $OFFSET with \"$OVERWRITE_CONTENT\" using dd..."
# dd 的 seek 参数表示跳过输出文件的前 N 个块 (bs=1 表示按字节跳过)
# conv=notrunc 表示不截断输出文件
echo -n "$OVERWRITE_CONTENT" | dd of="$TEST_FILE" bs=1 seek=$OFFSET conv=notrunc &>/dev/null

# 4. 验证文件内容
echo "Verifying file content..."
FINAL_CONTENT=$(cat "$TEST_FILE")
echo "Final content of $TEST_FILE: \"$FINAL_CONTENT\""

# 预期结果: "ABCDEFGHIJ12345PQRSTUVWXYZ"
EXPECTED_PREFIX="${INITIAL_CONTENT:0:$OFFSET}"
EXPECTED_SUFFIX="${INITIAL_CONTENT:$((OFFSET + ${#OVERWRITE_CONTENT}))}"
EXPECTED_CONTENT="${EXPECTED_PREFIX}${OVERWRITE_CONTENT}${EXPECTED_SUFFIX}"

if [ "$FINAL_CONTENT" == "$EXPECTED_CONTENT" ]; then
    echo "SUCCESS: File content matches expected. lseek (via dd) appears to be working."
else
    echo "FAILURE: File content does NOT match expected."
    echo "Expected: \"$EXPECTED_CONTENT\""
    echo "Got:      \"$FINAL_CONTENT\""
fi

# 5. 清理
rm "$TEST_FILE"
echo "Cleaned up $TEST_FILE"

echo "--- Test Complete ---"