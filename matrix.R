# 生成100x100随机矩阵
set.seed(123)  # 设置随机种子以确保结果可重现
matrix_100 <- matrix(runif(100 * 100, min = 0, max = 100), nrow = 100, ncol = 100)

# 查看矩阵基本信息
cat("矩阵维度:", dim(matrix_100), "\n")
cat("矩阵前5行5列:\n")
print(matrix_100[1:5, 1:5])

# 基本计算
# 1. 矩阵行列和
row_sums <- rowSums(matrix_100)
col_sums <- colSums(matrix_100)

# 2. 矩阵均值、标准差
matrix_mean <- mean(matrix_100)
matrix_sd <- sd(matrix_100)

# 3. 矩阵特征值和特征向量
eigen_result <- eigen(matrix_100)

# 4. 矩阵行列式
matrix_det <- det(matrix_100)

# 5. 矩阵求逆（如果可逆）
if(matrix_det != 0) {
  matrix_inv <- solve(matrix_100)
} else {
  cat("矩阵不可逆\n")
}

# 6. 矩阵乘法（自乘）
matrix_squared <- matrix_100 %*% matrix_100

# 输出结果
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

# 可视化矩阵的热图（可选）
heatmap(matrix_100, 
        main = "100x100随机矩阵热图",
        xlab = "列", 
        ylab = "行",
        col = heat.colors(100))