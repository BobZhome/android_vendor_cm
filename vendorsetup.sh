<<<<<<< HEAD
for combo in $(cat vendor/cm/jenkins-build-targets)
=======
for combo in $(wget -o /dev/null -O - https://raw.github.com/CyanogenMod/hudson/master/cm-build-targets | grep cm-10.1 | awk {'print $1'})
>>>>>>> 13e5cb0... Update path for build roster
do
    add_lunch_combo $combo
done
