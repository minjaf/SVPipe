# SVPipe
Small shell wrapper for SV calling from WGS data using cue tool

**Notes**:
To copy result to the remote server, run something like:
```bash
rsync -axv --progress -e "ssh -T -o Compression=no -x" . --include "i10*/" --include "i10*/*/"  --include "i10*/*/reports/" --include "i10*/10*/.*" --include "*.vcf" --exclude "*" . vfishman@143.107.29.10:/home/venus/lago/vfishman/results/ --dry-run```