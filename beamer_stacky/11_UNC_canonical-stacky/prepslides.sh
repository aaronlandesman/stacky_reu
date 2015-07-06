## code to replace a string in every file in a folder



NEWFILENAME=test

## run this in the main folder and in the slides folder
for file in *tex; do sed 's_beamerTemplate_'$NEWFILENAME'_g' $file > temp && mv temp $file; done




## run this if necesary
for file in *tex; do sed 's_../beamerTemplate_beamerTemplate_g' $file > temp && mv temp $file; done


  echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> slides.tex ;
  echo "% Title of SECTION" >> slides.tex ;
  echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> slides.tex;
  echo "   \input{slides/slide001}     %% {Title of  SLIDE}" >> slides.tex;
  echo " "

for n in {2..9}; do
  echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> slides.tex ;
  echo "% Title of SECTION" >> slides.tex ;
  echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> slides.tex;
  echo "   % \input{slides/slide00"$n"}     %% {Title of  SLIDE}" >> slides.tex;
  echo " "
done

for n in {10..20}; do
  echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> slides.tex;
  echo "% Title of SECTION" >> slides.tex;
  echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> slides.tex;
  echo " %  \input{slides/slide0"$n"}     %% {Title of  SLIDE}" >> slides.tex;
  echo " "
done

for file in *tex; do sed 's_firstLecture.tex_EUMMAFermat.tex_g' $file > temp && mv temp $file; done

## code to replace a string in every file in a folder




NEWFILENAME=cohenLenstra2012Lausanne

## run this in the main folder and in the slides folder
for file in *tex; do sed 's_cohenLenstra2012HawaiiAMS_'$NEWFILENAME'_g' $file > temp && mv temp $file; done




## run this if necesary
for file in *tex; do sed 's_../beamerTemplate_beamerTemplate_g' $file > temp && mv temp $file; done


  echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> slides.tex ;
  echo "% Title of SECTION" >> slides.tex ;
  echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> slides.tex;
  echo "   \input{slides/slide001}     %% {Title of  SLIDE}" >> slides.tex;
  echo " "

for n in {2..9}; do
  echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> slides.tex ;
  echo "% Title of SECTION" >> slides.tex ;
  echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> slides.tex;
  echo "   % \input{slides/slide00"$n"}     %% {Title of  SLIDE}" >> slides.tex;
  echo " "
done

for n in {10..20}; do
  echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> slides.tex;
  echo "% Title of SECTION" >> slides.tex;
  echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> slides.tex;
  echo " %  \input{slides/slide0"$n"}     %% {Title of  SLIDE}" >> slides.tex;
  echo " "
done

for file in *tex; do sed 's_firstLecture.tex_EUMMAFermat.tex_g' $file > temp && mv temp $file; done