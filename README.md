# SVPipe
Small shell wrapper for SV calling from WGS data using cue tool

**Notes**:
To copy result to the remote server, run something like:
```bash
rsync -axv --progress -e "ssh -T -o Compression=no -x" . --include "i10*/" --include "i10*/*/"  --include "i10*/*/reports/" --include "i10*/10*/.*" --include "*.vcf" --exclude "*" . vfishman@143.107.29.10:/home/venus/lago/vfishman/results/ --dry-run```

rsync -axv --progress -e "ssh -T -o Compression=no -x" . --include "i10*/" --include "i10*/*/"  --include "i10*/*/delly/" --include "i10*/10*/.*" --include "*.vcf" --include "*.*done" --include "*.*fail" --exclude "*" . vfishman@143.107.29.10:/home/venus/lago/vfishman/results/
```

To copy CRAM files:
```bash
for i in {16..29}; do echo $i; rsync --include "1${i}*.cram" --exclude='*' -aHAXxv --numeric-ids --progress -e "ssh -T -o Compression=no -x" vfishman@143.107.29.10:/home/venus/lago/vfishman/2023Aug14_copy/ .; done
```