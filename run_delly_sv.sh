basedir="/home/venus/mar/share_pesquisa/debora_veniamin/GemeosDiscordantes_TAOS"; bams=$(find $basedir -name "*.bam");

set -e

for i in $bams
do
    bn=$(basename $i)
    splitext=$(echo $bn | cut -d "." -f1)
    if ! [ -f "$splitext/${splitext}.bam" ]
    then
        ln -s $i $splitext/${splitext}.bam
    fi
    
    if [ -d "${splitext}/delly" ]
    then
		echo "directory exist"
    else	
		mkdir "${splitext}/delly"
    fi
    out=${splitext}/delly/delly.sv.vcf ;
#    if [ -f $out ]
#    then
#                echo "sv results file exist, skipping $i"
#    else
                echo "ruinning delly sv"
		date
		~/soft/delly/delly/src/delly call -g ~/common/hg38/Homo_sapiens_assembly38.fasta -x ~/common/hg38/human.hg38.excl.tsv $splitext/${splitext}.bam > $out 
        date
#    fi 
done
