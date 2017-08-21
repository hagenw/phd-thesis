file = wierstorf2014-perceptual_assessment_of_sound_field_synthesis
make:
	 	# Run LaTeX the save way
		@pdflatex $(file)
		@biber $(file)
		@pdflatex $(file)
		# Reduce size of pdf
		@gs -sDEVICE=pdfwrite \
		    -dCompatibilityLevel=1.4 \
			-dNOPAUSE \
			-dQUIET \
			-dBATCH \
			-sOutputFile=$(file)_tmp.pdf \
			$(file).pdf
		# Adjust metadata
		@pdftk $(file)_tmp.pdf \
               update_info metadata.txt \
               output $(file).pdf
		@ rm $(file)_tmp.pdf

one:
		# Run LaTeX just once
		@pdflatex $(file)

clean:
		@rm *aux *out *log *blg *bcf *bbl *xml *toc
