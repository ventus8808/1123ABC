# 设置工作目录为当前脚本所在目录
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
# 或者手动设置：setwd("/Users/ventus/Repository/1123abc")

# 生成200x200随机矩阵
set.seed(123)  # 设置随机种子以确保结果可重现
matrix_200 <- matrix(runif(200 * 200, min = 0, max = 100), nrow = 200, ncol = 200)

# 保存原始矩阵到文件
write.csv(matrix_200, "random_matrix_200x200.csv", row.names = FALSE)
cat("原始矩阵已保存到: random_matrix_200x200.csv\n")

# 查看矩阵基本信息
cat("矩阵维度:", dim(matrix_200), "\n")
cat("矩阵前5行5列:\n")
print(matrix_200[1:5, 1:5])

# 基本计算
# 1. 矩阵行列和
row_sums <- rowSums(matrix_200)
col_sums <- colSums(matrix_200)

# 2. 矩阵均值、标准差
matrix_mean <- mean(matrix_200)
matrix_sd <- sd(matrix_200)

# 3. 矩阵特征值和特征向量
eigen_result <- eigen(matrix_200)

# 4. 矩阵行列式
matrix_det <- det(matrix_200)

# 5. 矩阵求逆（如果可逆）
if(matrix_det != 0) {
  matrix_inv <- solve(matrix_200)
  write.csv(matrix_inv, "matrix_inverse_200x200.csv", row.names = FALSE)
  cat("逆矩阵已保存到: matrix_inverse_200x200.csv\n")
} else {
  cat("矩阵不可逆\n")
}

# 6. 矩阵乘法（自乘）
matrix_squared <- matrix_200 %*% matrix_200

# 保存计算结果到文件
results <- list(
  matrix_dimensions = dim(matrix_200),
  matrix_mean = matrix_mean,
  matrix_sd = matrix_sd,
  matrix_determinant = matrix_det,
  eigenvalues = eigen_result$values[1:10],  # 只保存前10个特征值
  row_sums_range = range(row_sums),
  col_sums_range = range(col_sums)
)

# 保存结果为RData文件
save(results, file = "matrix_calculations_results.RData")

# 保存结果为文本文件
sink("matrix_calculations_summary.txt")
cat("=== 200x200随机矩阵计算结果 ===\n\n")
cat("矩阵维度:", results$matrix_dimensions, "\n")
cat("矩阵均值:", round(results$matrix_mean, 2), "\n")
cat("矩阵标准差:", round(results$matrix_sd, 2), "\n")
cat("矩阵行列式:", results$matrix_determinant, "\n")
cat("前5个特征值:", round(Re(results$eigenvalues[1:5]), 2), "\n")
cat("行和范围:", round(results$row_sums_range, 2), "\n")
cat("列和范围:", round(results$col_sums_range, 2), "\n")
cat("\n计算完成时间:", Sys.time(), "\n")
sink()

# 输出结果到控制台
cat("\n=== 基本统计 ===\n")
cat("矩阵均值:", round(matrix_mean, 2), "\n")
cat("矩阵标准差:", round(matrix_sd, 2), "\n")
cat("矩阵行列式:", matrix_det, "\n")

cat("\n=== 特征值信息 ===\n")
cat("最大特征值:", round(Re(eigen_result$values[1]), 2), "\n")
cat("特征值范围:", round(range(Re(eigen_result$values)), 2), "\n")

cat("\n=== 行列和统计 ===\n")
cat("行和范围:", round(range(row_sums), 2), "\n")
cat("列和范围:", round(range(col_sums), 2), "\n")

cat("\n=== 文件保存信息 ===\n")
cat("1. 原始矩阵: random_matrix_200x200.csv\n")
cat("2. 计算结果摘要: matrix_calculations_summary.txt\n")
cat("3. 完整结果: matrix_calculations_results.RData\n")
if(matrix_det != 0) cat("4. 逆矩阵: matrix_inverse_200x200.csv\n")

# 可视化矩阵的热图（可选）
png("matrix_heatmap_200x200.png", width = 800, height = 800)
heatmap(matrix_200, 
        main = "200x200随机矩阵热图",
        xlab = "列", 
        ylab = "行",
        col = heat.colors(100),
        labRow = FALSE,  # 不显示行标签（太多）
        labCol = FALSE)  # 不显示列标签
dev.off()
cat("5. 热图: matrix_heatmap_200x200.png\n")

# 生成一个简单的R脚本来验证保存的数据
verification_script <- "
# 验证脚本 - 检查保存的数据
cat('=== 数据验证 ===\\n')

# 检查CSV文件
if(file.exists('random_matrix_200x200.csv')) {
  m <- read.csv('random_matrix_200x200.csv')
  cat('✓ 矩阵文件加载成功，维度:', dim(m), '\\n')
}

# 检查文本摘要
if(file.exists('matrix_calculations_summary.txt')) {
  cat('✓ 文本摘要文件存在\\n')
}

# 检查RData文件
if(file.exists('matrix_calculations_results.RData')) {
  load('matrix_calculations_results.RData')
  cat('✓ RData文件加载成功\\n')
  cat('矩阵均值:', results$matrix_mean, '\\n')
}

cat('验证完成!\\n')
"

writeLines(verification_script, "verify_saved_data.R")
cat("6. 验证脚本: verify_saved_data.R\n")

cat("\n所有文件已保存到当前目录:", getwd(), "\n")