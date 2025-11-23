#!/bin/bash
# submit_r_job.sh - 提交R脚本到SLURM

# 设置作业参数
JOB_NAME="matrix_200x200"
R_SCRIPT="matrix.R"
PARTITION="kshctest"
TIME="1-00:00:00"  # 1天

echo "=== 提交R脚本到SLURM ==="
echo "作业名称: $JOB_NAME"
echo "R脚本: $R_SCRIPT"
echo "分区: $PARTITION"
echo "时间限制: $TIME"

# 检查R脚本是否存在
if [ ! -f "$R_SCRIPT" ]; then
    echo "错误: R脚本 $R_SCRIPT 不存在!"
    exit 1
fi

# 使用heredoc方式提交作业
sbatch << EOF
#!/bin/bash
#SBATCH --partition=$PARTITION
#SBATCH --job-name=$JOB_NAME
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=48G
#SBATCH --time=$TIME
#SBATCH --output=${JOB_NAME}_%j.out
#SBATCH --error=${JOB_NAME}_%j.err

# 加载模块
module purge
module load anaconda/3

# 激活conda环境
conda activate 1123b

# 进入提交目录
cd \$SLURM_SUBMIT_DIR

echo "=== 作业开始 ==="
echo "主机名: \$(hostname)"
echo "工作目录: \$(pwd)"
echo "开始时间: \$(date)"
echo "R脚本: $R_SCRIPT"

# 运行R脚本
Rscript $R_SCRIPT

echo "作业结束时间: \$(date)"
echo "=== 作业完成 ==="
EOF

echo "作业已提交!"
echo "使用 'squeue -u \$USER' 查看作业状态"