for combo in `cat vendor/cm/build-targets.txt | grep -v ^# | grep -v ^$`; do
    add_lunch_combo $combo
done
