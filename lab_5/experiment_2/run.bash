N=$1
K=$2

for (( i=0; i < K; ++i)) 
do
    ./mem.bash $N &
    echo $!
    sleep 1
done

echo 
