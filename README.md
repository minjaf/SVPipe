# SVPipe
Small shell wrapper for SV calling from WGS data using cue tool

**Notes**:
To copy result to the remote server, run something like:
```bash
rsync -axv --progress -e "ssh -T -o Compression=no -x" . --include "i10*/" --include "i10*/*/"  --include "i10*/*/reports/" --include "i10*/10*/.*" --include "*.vcf" --exclude "*" . vfishman@143.107.29.10:/home/venus/lago/vfishman/results/ --dry-run```

rsync -axv --progress -e "ssh -T -o Compression=no -x" . --include "i10*/" --include "i10*/*/"  --include "i10*/*/delly/" --include "i10*/10*/.*" --include "*.vcf" --include "*.*done" --include "*.*fail" --exclude "*" . vfishman@143.107.29.10:/home/venus/lago/vfishman/results/
```

More precise command (copy from CPU to Brazil machine):
```
rsync -axv --progress -e "ssh -T -o Compression=no -x" . --include "i*/" --include "i*/*/"  --include "i1*/*/reports/" --include "i*/*/reports/.*" --include "*.vcf" --include "*.*done" --include "*.*fail" --include "*.bed" --include "*.config" --exclude "*" . vfishman@143.107.29.10:/home/venus/lago/vfishman/results/
```

To copy CRAM files:
```bash
for i in {16..29}; do echo $i; rsync --include "1${i}*.cram" --exclude='*' -aHAXxv --numeric-ids --progress -e "ssh -T -o Compression=no -x" vfishman@143.107.29.10:/home/venus/lago/vfishman/2023Aug14_copy/ .; done
```

To check whether all cram files were processed:
```bash
cramdir="/home/venus/lago/vfishman"; \
resultsdir="/home/vfishman/projects/1000gSVs/results/"; \
find $cramdir -name "*.cram" | while read -r line; do \
  cramfile=$(basename $line | cut -d "." -f1); \
  prefix=i$(echo $cramfile | cut -c1-3); \
  cramoutdir=${resultsdir}/${prefix}/${cramfile}/; \
  cue_vcf="$cramoutdir/reports/svs.vcf"; \
  cue_done="$cramoutdir/.${cramfile}.done"; \
  delly_vcf="$cramoutdir/delly/delly.sv.vcf"; \
  delly_done="$cramoutdir/delly/.done"; \
  if [ ! -f $cue_vcf ] ; then \
    echo "No cue vcf! cram: $cramfile vcf: $cue_vcf"; \
  fi; \
  if [ ! -f $cue_done ] ; then \
    echo "No cue .done! cram: $cramfile .done: $cue_done"; \
  fi; \
  if [ ! -f $delly_vcf ] ; then \
    echo "No delly .vcf! cram: $cramfile vcf: $delly_vcf"; \
  fi; \
  if [ ! -f $delly_done ] ; then \
    echo "No delly .done! cram: $cramfile vcf: $delly_done"; \
  fi; \
done
```

cue_vcf=3; if [ ! -f $cue_vcf ] ; then \
    echo "!13!"; \
fi;

echo "!No cue vcf! cram: $cramfile vcf: $cue_vcf"; \