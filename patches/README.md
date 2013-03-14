==Applying a Patch

You must be in the root directory of the plugin to apply the patch.
First you should check to make the sure patch can be applied cleanly. Below is an example:

    git apply --check patches/compatibility_redmine_newissuealert.patch

If you don't get any errors then you are ok to proceed. Below is an example of applying the patch.

    git apply patches/compatibility_redmine_newissuealert.patch

==More Info

Git Patching Information: https://ariejan.net/2009/10/26/how-to-create-and-apply-a-patch-with-git

The reason that this patch is necessary: http://www.redmine.org/boards/3/topics/20208