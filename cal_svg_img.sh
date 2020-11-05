for _lang in en fr de es it nl no pt sl da id ru
do
      rm -f /tmp/*.svg
      rm -f /tmp/*.pdf
      make -f cal_svg_img.mk _LANG=$_lang png
done
