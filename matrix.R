# matrix.R - 200x200矩阵计算
cat("=== 开始200x200矩阵计算 ===\n")
cat("时间:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
cat("工作目录:", getwd(), "\n\n")

set.seed(123)

# 生成200x200随机矩阵
cat("生成200x200随机矩阵...\n")
matrix_200 <- matrix(runif(40000, 0, 100), 200, 200)

# 基本计算
cat("计算基本统计量...\n")
results <- list(
    dimensions = dim(matrix_200),
    mean = mean(matrix_200),
    sd = sd(matrix_200),
    determinant = det(matrix_200),
    timestamp = Sys.time()
)

# 保存结果
write.csv(matrix_200, "random_matrix_200x200.csv", row.names = FALSE)
saveRDS(results, "matrix_results.rds")

# 输出摘要
sink("calculation_summary.txt")
cat("200x200矩阵计算结果\n")
cat("===================\n\n")
cat("计算时间:", results$timestamp, "\n")
cat("矩阵维度:", results$dimensions, "\n")
cat("矩阵均值:", round(results$mean, 4), "\n")
cat("矩阵标准差:", round(results$sd, 4), "\n")
cat("行列式值:", results$determinant, "\n")
sink()

cat("计算完成！生成的文件:\n")
print(list.files(pattern = "\\.(csv|rds|txt)$"))
cat("结束时间:", Sys.time(), "\n")
