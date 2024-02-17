#!/bin/bash

DIR_PATH=$(realpath "$(dirname "${BASH_SOURCE[0]}")")

# Imports
. "$DIR_PATH"/helpers/logger.sh

# Assign CLI args
while getopts i: flag
do
    case "${flag}" in
        i) input=${OPTARG};;
    esac
done

# Check for empty input
if [[ -z "$input" ]]; then
    error '\nERROR: No input file was provided. Use "-i FILE_NAME" argument\n'
    exit 1
fi

# Set up paths
input_path=$(dirname "$input")
input_file=$(basename "$input")
input_filename="${input_file%.*}"
input_sub="${input_path}/${input_filename}.srt"
output_sub="${input_path}/${input_filename}.ass"
output_vid="${input_path}/${input_filename}_subs.mp4"

log "\n======================== PROCESSING \"${input_file}\" (Burn in subtitles) ========================\n"

# Check for non-existent input files
if [[ ! -f "$input" ]]; then
    error '\nERROR: The input file provided does not exist\n'
    exit 1
fi

if [[ ! -f "$input_sub" ]]; then
    error '\nERROR: The input file provided does not have an accompanying subtitles file in SRT format. Place the subtitles file next to the video with the same filename\n'
    exit 1
fi

# Process subtitles
ffmpeg -y -i "$input_sub" "$output_sub"

# Process video
ffmpeg -y -i "$input" -vf "ass=${output_sub}" "$output_vid"

# Cleanup
rm "$output_sub"

log "\nFinished processing \"${input_file}\"\n"