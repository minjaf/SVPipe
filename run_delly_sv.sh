basedir=$1; 
ext=".cram"
bams=$(find $basedir -name "*"$ext);

set -e

for i in $bams
do
    bn=$(basename $i)
    splitext=$(echo $bn | cut -d "." -f1)
    if ! [ -f "$splitext/${splitext}$ext" ]
    then
        echo "Creating simlink: $splitext/${splitext}$ext"
        ln -s $i $splitext/${splitext}$ext
    fi
    
    if [ -d "${splitext}/delly" ]
    then
		  echo "delly output directory exist"
    else
      echo "creating directory ${splitext}/delly"	
		  mkdir "${splitext}/delly"
    fi
    out=${splitext}/delly/delly.sv.vcf ;
    if [ -f "${splitext}/delly/.done" ]
    then
              echo "Skipping $i"
    else
              echo "ruinning delly sv"
    fi 
		date
		# ~/soft/delly/delly/src/delly call \
    #         -g ~/common/hg38/Homo_sapiens_assembly38.fasta \
    #         -x ~/common/hg38/human.hg38.excl.tsv \
    #         $splitext/${splitext}.bam > $out 
    # echo "Done" > "${splitext}/delly/.done"
    date
done
