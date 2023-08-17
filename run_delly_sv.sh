basedir=$1; 
outdir=$2

ext=".cram"
fasta="$HOME/common/hg38/Homo_sapiens_assembly38.fasta"
bl_lst="$HOME/common/hg38/human.hg38.excl.tsv"

bams=$(find $basedir -name "*"$ext);
echo $bams

set -e

for i in $bams
do
    echo "Processing $i"
    bn=$(basename $i)
    splitext=$(echo $bn | cut -d "." -f1)
    if ! [ -f "$outdir/$splitext/${splitext}$ext" ]
    then
        echo "Creating simlink: $i $outdir/$splitext/${splitext}$ext"
        ln -s $(realpath $i) $outdir/$splitext/${splitext}$ext
    fi
    
    if [ -d "$outdir/${splitext}/delly" ]
    then
	echo "delly output directory exist"
    else
      	echo "creating directory $outdir/${splitext}/delly"	
	mkdir "$outdir/${splitext}/delly"
    fi
    out=$outdir/${splitext}/delly/delly.sv.vcf ;
    if [ -f "$outdir/${splitext}/delly/.done" ]
    then
              echo "Skipping $i"
	      continue
    else
	if ! [ -f "$outdir/$splitext/${splitext}${ext}.crai" ];
        then
        	echo "Index "$outdir/$splitext/${splitext}${ext}.crai not found, running samtools index on "$outdir/$splitext/${splitext}${ext}"
                set +eE
                samtools index -@ 20 "$outdir/$splitext/${splitext}${ext}"
                if [ $? -eq 0 ]; then
                        echo "Index done"
                else
                        echo "Index fail for sample $outdir/$splitext/${splitext}${ext}"
                        rm "$outdir/$splitext/${splitext}${ext}.crai"
                        echo "Index Fail" > $outdir/${splitext}/delly/.fail
                        continue
        	fi
	set -eE
	fi
    	echo "ruinning delly sv"
	date
	$HOME/soft/delly/delly/src/delly call \
            -g ${fasta} \
            -x ${bl_lst} \
            $outdir/$splitext/${splitext}${ext} \
            > $out \
            2>> delly_sv_logs.txt
            
    	echo "Done" > "$outdir/${splitext}/delly/.done"
	echo "Done"
	date    
    fi
done
