# 创建提交脚本
cat > submit_matrix_simple.sh << 'EOF'
#!/bin/bash
#SBATCH --partition=kshctest
#SBATCH --job-name=matrix_200x200
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --output=matrix_%j.out
#SBATCH --error=matrix_%j.err

# 使用当前已激活的conda环境
echo "使用conda环境: $CONDA_DEFAULT_ENV"

# 进入工作目录
cd $SLURM_SUBMIT_DIR

echo "=== 作业开始 ==="
echo "时间: $(date)"
echo "主机: $(hostname)"
echo "目录: $(pwd)"
echo "R版本: $(R --version | head -1)"

# 运行R脚本
Rscript matrix.R

echo "=== 作业结束 ==="
echo "时间: $(date)"
EOF

# 给执行权限
chmod +x submit_matrix_simple.sh