# autohotkey-scripts
My AutoHotkey scripts

## Office issue and how to fix it
Microsoft has a set of key bindings that are preconfigured and that may open unrelated Office windows when using ALT+` (tilde). [AHK reference](https://www.autohotkey.com/boards/viewtopic.php?f=13&t=65573)

You can fix this issue by running this from an elevated command line window -

`REG ADD HKCU\Software\Classes\ms-officeapp\Shell\Open\Command /t REG_SZ /d rundll32`

And to reverse it, run the following from an elevated command line window -

`REG DELETE HKCU\Software\Classes\ms-officeapp\Shell`
