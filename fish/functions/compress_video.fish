function compress_video -d "Compress video using ffmpeg with H.264"
    set -l input_file $argv[1]
    
    if test -z "$input_file"
        echo "Usage: compress_video <filepath>"
        return 1
    end

    if not test -f "$input_file"
        echo "Error: File '$input_file' not found."
        return 1
    end

    set -l output_file (path change-extension mp4 "$input_file")
    
    # If the input file is already an .mp4, add a suffix so it doesn't get overwritten
    if test "$input_file" = "$output_file"
        set output_file (path change-extension '' "$input_file")"_compressed.mp4"
    end

    echo "Compressing '$input_file' -> '$output_file'..."
    ffmpeg -i "$input_file" -vcodec libx264 -crf 28 -preset medium -c:a aac -b:a 128k "$output_file"
end
