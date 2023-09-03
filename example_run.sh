# create data and cue config for new cram files
cram_folder="/home/venus/lago/vfishman/2023Aug14_copy/";\
results_folder="/home/venus/lago/vfishman/results";\
for i in {110..115}; do \
    [ ! -d "${results_folder}/i$i/" ] && mkdir -p ${results_folder}/i$i/; \
    for j in ${cram_folder}/${i}*.cram; \
        do bash create_data_and_configs.sh $j ${results_folder}/i$i/; \
    done;\
done;

# run cue for set of folders on CPU
cram_folder="/mnt/10tb/home/vsfishman/genomes/crams/";\
results_folder="/mnt/10tb/home/vsfishman/genomes/process/";\
for i in {117..124}; do \
    [ ! -d "${results_folder}/i$i/" ] && mkdir -p ${results_folder}/i$i/; \
    for j in ${cram_folder}/${i}*.cram; \
        do bash create_data_and_configs.sh $j ${results_folder}/i$i/; \
    done;\
done;

bash run_cue.sh /home/vsfishman/genomes/process/i101/

/home/venus/lago/vfishman/results$ for i in {4..9}; do bash ~/soft/SVPipe/run_delly_sv.sh ~/projects/1000gSVs/results/i10${i}/ ~/projects/1000gSVs/results/i10${i}; done
