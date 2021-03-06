
`cp -r emacs ~/.emacs;cp .emacs ~/.emacs`

I used to use Emacs font
`sudo apt-get install fonts-inconsolata`
However, now I prefer the old `IBM 3270 medium` font.

Weechat

/set irc.look.smart_filter on
/set irc.look.smart_filter_delay 5
/filter add irc_smart * irc_smart_filter *
/server add freenode irc.freenode.net
/set irc.server.freenode.autojoin "#glibc,#linux,#R,#awk,#regex,##c,#cjeopardy,#clang,#algorithms,#emacs,#gcj,##math,#openbsd,#openbsd-daily,#ruby,#perl,#python,#ksh,#redis,##kernel,##kernelnewbies,#pcre,#metasploit,##posix,#nethack,#nethack-dev,#ipfs,#devious,#freebsd,#netbsd,##crypto,#bitcoin-core-dev,#pfsense-br,##not-a-honeypot,##freebsd-br,#csc,#dfsc,#ed,#plan9,#suckless,#cat-v,#ccc"

/server add 2600 irc.2600.net
/set irc.server.2600.autojoin "#2600es"

/server add hackint irc.hackint.org:9999
/set irc.server.hackint.autojoin "#ccc"

/server add anonops irc.anonops.com/6697 -ssl 
/set irc.anonops.com.autojoin "##c"

For ksh on BSD `export PS1='$HOSTNAME ╭── \u@\h ${PWD}\n ╰─$ '` this will show current dir

ref: http://gongzhitaao.org/orgcss/ (related to making teh blog pretty)
ref: https://pavpanchekha.com/blog/org-mode-publish.html
ref: http://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html (maybe org-publish is simpler an more straightforward than org-page)
ref: http://codyreichert.github.io/blog/2015/07/05/blogging-with-emacs-and-org-mode/ (org-page, might end up using this for my blog)
ref: http://blog.0x7cc.net/posts/Custom-Theme-for-Org-page.html (org-page themes how-to)
ref: https://mixandgo.com/blog/how-ive-convinced-emacs-to-dance-with-ruby ( A lot need to be taken from this Tut, very gooooooooooood)
ref: https://martinralbrecht.wordpress.com/2014/11/03/c-development-with-emacs/
ref: https://martinralbrecht.wordpress.com/2015/02/12/sage-development-with-emacs/ 
ref: http://howardism.org/Technical/Emacs/literate-programming-tutorial.html 
ref: https://ayueer.wordpress.com/2006/07/01/some-emacs-tricks-on-ruby/ 
ref: http://worace.works/2016/06/07/getting-started-with-emacs-for-ruby/
ref: http://pragmaticemacs.com/emacs/advanced-undoredo-with-undo-tree/
