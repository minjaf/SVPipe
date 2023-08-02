basedir="/home/venus/mar/share_pesquisa/ana_regina/" 
for i in ${basedir}*.bam
do
    bn=$(basename $i)
    splitext=$(echo $bn | cut -d "." -f1)
    out_suffix=/delly
    if [ -d "${splitext}/${out_suffix}" ]
    then
		echo "directory exist"
    else	
		mkdir "${splitext}/${out_suffix}"
    fi
    out=${splitext}/${out_suffix}/delly.cnv.bcf ;
    svfile=${splitext}/${out_suffix}/delly.sv.vcf
#    if [ -f $out ]
#    then
#                echo "sv results file exist, skipping $i"
#    else
                echo "ruinning delly cnv"
		date

		~/soft/delly/delly/src/delly cnv -g ~/common/hg38/Homo_sapiens_assembly38.fasta -m ~/common/hg38/Homo_sapiens.GRCh38.dna.primary_assembly.fa.r101.s501.blacklist.gz -l $svfile -o $out $(realpath $i)
#    fi 
done
