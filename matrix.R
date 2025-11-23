# 备份原文件
cp matrix.R matrix.R.backup

# 创建修复版本
cat > matrix.R << 'EOF'
# matrix.R - 服务器版本（无rstudioapi依赖）
cat("=== 200x200矩阵计算 ===\n")
cat("开始时间:", Sys.time(), "\n")
cat("工作目录:", getwd(), "\n\n")

# 设置随机种子
set.seed(123)

# 生成200x200随机矩阵
cat("生成200x200随机矩阵...\n")
matrix_200 <- matrix(runif(200 * 200, min = 0, max = 100), nrow = 200, ncol = 200)

# 基本计算
cat("进行基本计算...\n")
row_sums <- rowSums(matrix_200)
col_sums <- colSums(matrix_200)
matrix_mean <- mean(matrix_200)
matrix_sd <- sd(matrix_200)
matrix_det <- det(matrix_200)

# 特征值计算（只计算前几个避免内存问题）
cat("计算特征值（前10个）...\n")
eigen_values <- try(eigen(matrix_200, symmetric = FALSE, only.values = TRUE)$values[1:10])

# 保存结果
cat("保存结果文件...\n")

# 保存矩阵数据
write.csv(matrix_200, "random_matrix_200x200.csv", row.names = FALSE)

# 保存计算结果
results <- list(
    dimensions = dim(matrix_200),
    mean = matrix_mean,
    sd = matrix_sd,
    determinant = matrix_det,
    row_sums_range = range(row_sums),
    col_sums_range = range(col_sums),
    timestamp = Sys.time()
)

if(!inherits(eigen_values, "try-error")) {
    results$eigenvalues <- eigen_values
    results$max_eigenvalue <- max(Re(eigen_values))
}

saveRDS(results, "matrix_results.rds")

# 生成摘要报告
sink("calculation_summary.txt")
cat("200x200矩阵计算结果摘要\n")
cat("========================\n\n")
cat("计算完成时间:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
cat("矩阵维度:", results$dimensions, "\n")
cat("矩阵均值:", round(results$mean, 4), "\n")
cat("矩阵标准差:", round(results$sd, 4), "\n")
cat("矩阵行列式:", results$determinant, "\n")
cat("行和范围:", round(results$row_sums_range, 4), "\n")
cat("列和范围:", round(results$col_sums_range, 4), "\n")
if(!is.null(results$max_eigenvalue)) {
    cat("最大特征值:", round(results$max_eigenvalue, 4), "\n")
}
sink()

cat("\n=== 计算完成 ===\n")
cat("生成的文件:\n")
system("ls -lh *.csv *.rds *.txt 2>/dev/null || echo '暂无结果文件'")
cat("结束时间:", Sys.time(), "\n")
EOF