for i in {101..101}; do for j in ~/genomes/crams/${i}*.cram; do bash create_data_and_configs.sh $j /home/vsfishman/genomes/process/i$i/; done; done;
bash run_cue.sh /home/vsfishman/genomes/process/i101/

/home/venus/lago/vfishman/results$ for i in {4..9}; do bash ~/soft/SVPipe/run_delly_sv.sh ~/projects/1000gSVs/results/i10${i}/ ~/projects/1000gSVs/results/i10${i}; done
