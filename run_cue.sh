set -eE

trap 'echo "Script execution faild! Error: $? , line: $LINENO"' ERR

basedir=$1
cd $basedir;
basedir="."

for dir in ${basedir}/*; 
do 
        sample=$(basename $dir)
        if [ -f "$dir/.${sample}.done" ] || \
           [ -f "$dir/.${sample}.fail" ]  || \
           [ -f $dir ] || \
           ! [ -f "$dir/$sample.cram" ];
        then 
                echo "skipping $dir"; 
                continue; 
        else 
                echo "Starting $dir";
                date '+%d/%m/%Y %H:%M:%S'
                eval "$(conda shell.bash hook)"
                conda activate cue;
                if ! [ -f "$dir/$sample.cram.crai" ];
                then
                    echo "Index "$dir/$sample.cram.crai not found, running samtools index on "$dir/$dir.cram"
                    set +eE
                    samtools index -@ 20 "$dir/$sample.cram"
                    if [ $? -eq 0 ]; then
                        echo "Index done"
                    else
                        echo "Index fail for sample $dir"
                        rm "$dir/$sample.cram.crai"
                        echo "Undex Fail" > ${dir}/.${sample}.fail
                        continue
                    fi
                    set -eE
                fi
                export PYTHONPATH="$HOME/soft/cue:soft/cue/engine/"
		set +eE
		rm -r ${dir}/*.auxindex* ${dir}/annotat* ${dir}/images ${dir}/logs ${dir}/reports
                set -eE
                python ~/soft/cue/engine/call.py \
                                --data_config ${dir}/${sample}.data.config \
                                --model_config ${dir}/${sample}.model.config \
                                 &>> cue_logs.txt
                echo "Done" > ${dir}/.${sample}.done
            	date '+%d/%m/%Y %H:%M:%S'
	fi
done