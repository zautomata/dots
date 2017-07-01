;; Mohamed Fouad ;; zautomata@gmail.com
;; hackspree.com

;; blog
;; ref:: http://gongzhitaao.org/orgcss/ (related to making teh blog pretty)
;; ref: https://pavpanchekha.com/blog/org-mode-publish.html
;; ref: http://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html (maybe org-publish is simpler an more straightforward than org-page)

;; not used anymore, should be removed
;; ref: http://codyreichert.github.io/blog/2015/07/05/blogging-with-emacs-and-org-mode/ (org-page, might end up using this for my blog)
;; ref: http://blog.0x7cc.net/posts/Custom-Theme-for-Org-page.html (org-page themes how-to)

;; ref: https://mixandgo.com/blog/how-ive-convinced-emacs-to-dance-with-ruby ( A lot need to be taken from this Tut, very gooooooooooood)
;; ref: https://martinralbrecht.wordpress.com/2014/11/03/c-development-with-emacs/
;; ref: https://martinralbrecht.wordpress.com/2015/02/12/sage-development-with-emacs/ 
;; ref: http://howardism.org/Technical/Emacs/literate-programming-tutorial.html 
;; ref: https://ayueer.wordpress.com/2006/07/01/some-emacs-tricks-on-ruby/ 
;; ref: http://worace.works/2016/06/07/getting-started-with-emacs-for-ruby/
;; ref: http://pragmaticemacs.com/emacs/advanced-undoredo-with-undo-tree/


;; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

;; activate all the packages (in particular autoloads)
(package-initialize)

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; list the packages you want
(setq package-list '(better-defaults
                     solarized-theme
                     ;;kooten-theme
                     ;;helm
                     ;;helm-projectile
                     ;;helm-ag
                     evil
                     key-chord
                     restart-emacs ;; M-x restart-emacs
                     ruby-electric
                     seeing-is-believing
                     ;;chruby ;;rbenv
                     yasnippet           
                     inf-ruby
                     ess
                     flycheck
                     company ;; https://company-mode.github.io/
                     magit ;; one-thing-per-commit
                     ;;magit-popup
                     git-timemachine ;; step forward and backward through the history of a file
                     highlight-indentation  ;;TODO require it and use it for python projects
                     openwith ;; open links for files and webpages into external programs 
                     robe ;; required for robe-mode-hook https://github.com/dgutov/robe
                     org-pomodoro ;; https://github.com/lolownia/org-pomodoro
                     pos-tip  ;; https://www.topbug.net/blog/2016/11/03/emacs-display-function-or-variable-information-near-point-cursor/
                     mew ;; email in emacs world 
                     elfeed  ;; emacs RSS
                     restclient
                     ;;ob-restclient
                     ruby-test-mode
                     org-fstree
		     ;; pdf-tools ;; to read pdf. https://github.com/politza/pdf-tools  
		     ))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'better-defaults)

(setq inhibit-splash-screen t
      initial-scratch-message nil
      ;; initial-major-mode 'ruby-mode)
      initial-major-mode 'c-mode)

(load-theme 'ubuntu t)
;;(load-theme 'solarized-dark t)
;; (load-theme 'kooten t)

;; pdf-tools
;; (pdf-tools-install)


;; restclient
;; ref: http://jakemccrary.com/blog/2014/07/04/using-emacs-to-explore-an-http-api/
;; ref: https://www.youtube.com/watch?v=fTvQTMOGJaw
(require 'restclient)

;; ob-restclient.el - An extension to restclient.el for emacs that provides org-babel support
;; #+BEGIN_SRC restclient
;;   GET http://example.com
;; #+END_SRC
;; #+RESULTS:
;; #+BEGIN_SRC html
;; <!doctype html>
;; <html>
;; <head>
;; ...
;; </head>
;; </html>
;; #+END_SRC
(org-babel-do-load-languages
 'org-babel-load-languages
 '((restclient . t)))


(require 'org-fstree)

;; flycheck
;; ref: http://www.flycheck.org/  
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; company-mode
;; Completion will start automatically after you type a few letters.
;; Use M-n and M-p to select, <return> to complete or <tab> to complete the common part.
;; Search through the completions with C-s, C-r and C-o. Press M-(digit) to quickly complete with one of the first 10 candidates.
;; ref:  https://company-mode.github.io/
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)


;; A Git Porcelain inside Emacs
;; M-x magit-status or f5 to see git status, and in the status buffer:
;; s to stage files
;; c c to commit (type the message then C-c C-c to actually commit)
;; b b to switch to another branch
;; P u to do a git push
;; F u to do a git pull
;; try to press TAB
(require 'magit)
(global-set-key (kbd "<f5>") 'magit-status)

;; git-timemachine step forward and backward through the history of a file
;; p Visit previous historic version
;; n Visit next historic version
;; w Copy the abbreviated hash of the current historic version
;; W Copy the full hash of the current historic version
;; g Goto nth revision
;; q Exit the time machine. 
;; ref: https://github.com/pidu/git-timemachine 
(require 'git-timemachine)

;; yasnippet, docs: http://joaotavora.github.io/yasnippet/
;;TODO create some custom org-snippet for note-taking
(require 'yasnippet)
(yas-global-mode 1)

;; openwith for opening files in their respective external programs
(require 'openwith)
(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "evince" (file))))

;; org-mode configs
;; <s + tab to add codeblocks in org-mode
;; C-c' to edit codeblocks in their respective modes (C-c' to exit and go back to org-mode)
;; M-left & M-right to choose where to move org sub-headings
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)
;; enables org-babel for the mentioned languages; 
(org-babel-do-load-languages
 'org-babel-load-languages
 '( (perl . t)         
    (C . t)
    (ruby . t)
    ;;(shell . t)
    (python . t)
    (latex . t)
    (emacs-lisp . t)   
    ))
;; org-mode table behaviour to all other modes
;; ref: http://orgmode.org/manual/Orgtbl-mode.html#Orgtbl-mode
(add-hook 'message-mode-hook 'turn-on-orgtbl)

;; Breaking tasks down into subtasks
;; http://orgmode.org/manual/Breaking-down-tasks.html#Breaking-down-tasks
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)


;; emacs-speaks-statistics
(require 'ess)

;; Show line numbers
(global-linum-mode)
(setq linum-format "%d ")
(setq-default left-fringe-width  20)
;;(setq-default right-fringe-width  0)
;;(set-face-attribute 'fringe nil :background "yellow")



;; activate evil mode
(require 'evil)
(evil-mode 1)

;; Typography
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 100
                    :weight 'normal
                    :width 'normal)
;;(set-face-attribute 'default nil :height 80)

;;(require 'helm)
;;(require 'helm-projectile)
;;(require 'helm-ag)
;;(global-set-key (kbd "M-x") #'helm-M-x)
;;(global-set-key (kbd "s-f") #'helm-projectile-ag)
;;(global-set-key (kbd "s-t") #'helm-projectile-find-file-dwim)

;; Autoclose paired syntax elements like parens, quotes, etc
(require 'ruby-electric)
(add-hook 'ruby-mode-hook 'ruby-electric-mode)
;;(chruby "2.2.2");;TODO maybe use rbenv

;;Seeing Is Believing gives us:
;;C-. s - Run Seeing is Believing for the entire file
;;C-. c - Clear the Seeing is Believing output
;;C-. t - Tag a line to be "targeted" for evaluation by SiB
;;C-. x - Run only the "tagged" lines (those with trailing "# =>" markers)
(setq seeing-is-believing-prefix "C-.")
(add-hook 'ruby-mode-hook 'seeing-is-believing)
(require 'seeing-is-believing)

;; inf-ruby
;;Use C-c C-s to launch the inf-ruby process.
;;Use C-x o to switch to the inf-ruby pane and try running some random ruby snippets as you normally would from IRB or pry.
;;Go back to your Ruby buffer, select (by highlighting) a chunk of code, and use C-c C-r to push that Ruby code into the IRB session.
;;For example, try defining a class in your Ruby buffer, select the whole buffer, run C-c C-r, then swap over to the inf-ruby buffer and instantiate an instance of your class. Pretty cool!
;;Alternatively, use C-c M-r to run a selected chunk of code and automatically go to the ruby buffer
;;Finally, use helm-M-x (which we bound earlier to the default M-x keybinding) to search for âruby sendâ and see what other default bindings inf-ruby gives us.
;;If you do a lot of work in Rails or Sinatra, check out the commands inf-ruby-console-rails and inf-ruby-console-racksh. Using these commands inf-ruby can start a console session in the environment of your web project.
(autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)

;; ruby-test-mode
(require 'ruby-test-mode)
(add-hook 'ruby-mode-hook 'ruby-test-mode)
;; a smooth hook for ruby-test-mode
(add-hook 'compilation-finish-functions
          (lambda (buf strg)
            (switch-to-buffer-other-window "*compilation*")
            (read-only-mode)
            (goto-char (point-max))
            (local-set-key (kbd "q")
                           (lambda () (interactive) (quit-restore-window)))))
;;NOTE added by me
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;;Exit insert mode by pressing k and then j quickly
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
(key-chord-mode 1)

;; M-x simpleclip-paste and simpleclip-copy to interact with the clipboard
(setq x-select-enable-clipboard t)

;; add linenumber
(global-linum-mode t)

;; open emacs on fullscreen and maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; saves the minibuffer history
(savehist-mode 1)

;; shift + enter to add a newline under
(defun end-of-line-and-indented-new-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))
(global-set-key (kbd "<S-return>") 'end-of-line-and-indented-new-line)

;; automagically does a "chmod u+x" when you save a script file (starting with "#!").
;; Works with every kind of script, not only ruby ones. Just add that into .emacs
(add-hook 'after-save-hook
          '(lambda ()
             (progn
               (and (save-excursion
                      (save-restriction
                        (widen)
                        (goto-char (point-min))
                        (save-match-data
                          (looking-at "^#!"))))
                    (shell-command (concat "chmod u+x " 
                                           buffer-file-name))
                    (message (concat "Saved as script: 
   " buffer-file-name))))))

;; create directories if they don't exist while saving a file via C-x C-s
(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                  (make-directory dir t))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo tree mode                                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;turn on everywhere
(global-undo-tree-mode 1)
;; make ctrl-z undo
(global-set-key (kbd "C-z") 'undo)
;; make ctrl-Z redo
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-S-z") 'redo)

;; http://orgmode.org/worg/org-tutorials/org-plot.html
(local-set-key "\M-\C-g" 'org-plot/gnuplot)

;; ElDoc - part of emacs
;; https://www.emacswiki.org/emacs/ElDoc
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
                                        ;(defun my-eldoc-display-message (format-string &rest args)
                                        ;  "Display eldoc message near point."
                                        ;  (when format-string
                                        ;    (pos-tip-show (apply 'format format-string args))))
                                        ;(setq eldoc-message-function #'my-eldoc-display-message)

;; https://github.com/dgutov/robe
(add-hook 'ruby-mode-hook 'robe-mode)

(eval-after-load 'company
  '(push 'company-robe company-backends))

;; Turn on eldoc in ruby files to display info about the
;; method or variable at point
(add-hook 'ruby-mode-hook 'eldoc-mode)

;; Display Time
(display-time-mode 1)
(defface egoge-display-time
  '((((type x w32 mac))
     ;; #060525 is the background colour of my default face.
     (:foreground "#060525" :inherit bold))
    (((type tty))
     (:foreground "blue")))
  "Face used to display the time in the mode line.")
;; This causes the current time in the mode line to be displayed in
;; `egoge-display-time-face' to make it stand out visually.
(setq display-time-string-forms
      '((propertize (concat " " 24-hours ":" minutes " ")
                    'face 'egoge-display-time)))

(add-hook 'ruby-mode-hook
          (lambda ()
            (hs-minor-mode 1) ;; Enables folding
            (modify-syntax-entry ?: "."))) ;; Adds ":" to the word definition

;; erc - emacs IRC
(setq erc-log-channels-directory "~/.erc/logs/")

;; log files automatically written when you part a channel (or quit), add the following line:
(setq erc-save-buffer-on-part t)

;; (defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
;; (save-some-buffers t (lambda () (when (eq major-mode 'erc-mode) t))))

;; log on channel activity
;; (setq erc-save-buffer-on-part nil
;;     erc-save-queries-on-quit nil
;;   erc-log-write-after-send t
;; erc-log-write-after-insert t)


;; Cycle Buffers
;; (iswitchb-mode 1) ;;http://stackoverflow.com/questions/7394289/how-can-i-more-easily-switch-between-buffers-in-emacs
;;(global-set-key [C-right] 'next-buffer)
;;(global-set-key [M-p] 'previous-buffer)
;;(global-set-key [M-n] 'next-buffer)
(global-set-key (kbd "M-n")  'next-buffer)
(global-set-key (kbd "M-p")  'previous-buffer)
;;(global-set-key (kbd "M-p")  'mode-line-other-buffer)
;;(global-set-key [M-backtab] 'previous-buffer)
;;(global-set-key [tab] 'next-buffer)
;;(global-set-key [backtab] 'previous-buffer)

;; Cycling Windows
;; C-x o
;; Split windows Vertically C-x 3
;; Split windows Horizontally C-x 2
;; To close the current window, type C-x 0 (zero this time, not O).
;; To close all windows except the current one, type C-x 1.
;; Code while having IRC on ;) 
;; in org-mode shift left selects priority thus prefer not to activate this. 
;; (global-set-key [(shift left)] 'windmove-left)          ; move to left window
;; (global-set-key [(shift right)] 'windmove-right)        ; move to right window
;; (global-set-key [(shift up)] 'windmove-up)              ; move to upper window
;; (global-set-key [(shift down)] 'windmove-down)          ; move to lower window

;; RSS via ElFeed
(setq elfeed-feeds
      '("https://www.upwork.com/ab/feed/jobs/rss?contractor_tier=1&verified_payment_only=1&q=rails"
        "https://www.upwork.com/ab/feed/jobs/rss?contractor_tier=1&verified_payment_only=1&q=microservices"
        ))


;; M-x org-publish-project then Publish project: org
;; this publishes my project perfectly!
(require 'ox-publish)
(setq org-publish-project-alist
      '(
        ("org-notes"
         :base-directory "~/Opensource/zotherstupidguy.github.io/org"
         :base-extension "org"
         :publishing-directory  "~/Opensource/zotherstupidguy.github.io/public"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t

         :html-head "
<link href= \"css/stylesheet.css\" rel=\"stylesheet\" type=\"text/css\" />
"

         ;; No author / date at the bottom
         (setf org-html-home/up-format "")
         ;; Export as UTF-8
         (setf org-export-html-coding-system 'utf-8-unix)
         ;; The defaults are just fine for mathjax and style
         ;; However, they do not work over TLS due to mixed content errors
         (setf org-html-mathjax-options
               '((path "/etc/MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML")
                 (scale "100") (align "center") (indent "2em")
                 (mathml nil)))
         (setf org-html-mathjax-template
               "<script type=\"text/javascript\" src=\"%PATH\"></script>")
         (setf org-html-footnotes-section "<div id='footnotes'><!--%s-->%s</div>")
         (setf org-html-link-up "")
         (setf org-html-link-home "")
         (setf org-html-preamble nil)
         (setf org-html-postamble nil)
         (setf org-html-scripts "")

         :with-creator nil
         :section-numbers t
         :with-toc nil
         :with-latex t
         
         (setf user-full-name "zotherstupidguy")
         (setf user-mail-address "zotherstupidguy@gmail.com")
         )

        ("org-static"
         :base-directory "~/Opensource/zotherstupidguy.github.io/org"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory  "~/Opensource/zotherstupidguy.github.io/public"
         :recursive t
         :publishing-function org-publish-attachment
         )
        
        ("org" :components ("org-notes" "org-static")
         )
        )
      )


(defun auto-publish-blog-hook ()
  "Auto publish blog on save"
  ;; check if saved file is part of blog
  (if (org-publish-get-project-from-filename
       (buffer-file-name (buffer-base-buffer)) 'up)

      (save-excursion (org-publish-current-file)
                      (message "auto published blog") nil)
      )
  )

;; Enable auto-publish when a org file in blog is saved
(add-hook 'org-mode-hook
	  (lambda ()
	    (add-hook 'after-save-hook 'auto-publish-blog-hook nil nil)
	    ;; (local-set-key  (kbd "C-d C-t") 'self-insert-command)
	    ;; (global-set-key (kbd "C-d C-t") 'self-insert-command);
	    );
	  ;; use my intendation  
	  (setq-local org-list-indent-offset 4);
	  )

;; org-capture
;; - write template files (e.g. hackerrank.txt)
;; - Press your capture f6 key and shift-c to configure
(define-key global-map "\C-cc" 'org-capture)
;; force UTF-8
(setq org-export-coding-system 'utf-8)
(setq org-default-notes-file "~/Opensource/zotherstupidguy.github.io/org/index.org")

;; configure org-capture templates
(setq org-capture-templates
      
      '(("h" ;; hotkey
         "hackerrank problem" ;; name
         entry ;; type
         ;; heading type and title
         (file+headline org-default-notes-file "Problems")
         "* TODO %? 
  :PROPERTIES:   
  :SCHEDULED: <2017-02-19 Sun +2d/4d>
:DESCRIPTON: hackerrank problem, found in....
  :Difficulty: easy  
  :CATEGORY: none 
  :Source:    none 
  :ZPT:      1
  :END:
** :problem:
   -  something
*** :input: 
    - none 
*** :constraints:
    - none
*** :output: 
- none
*** :explanation:
- none
** :solution:
*** :questions:
    - none
*** :predicates:   
   - none
*** :implications:
- none
    #+BEGIN_SRC ruby
    #+END_SRC
    #+BEGIN_SRC C 
    #+END_SRC
** References       
-  none

   ----- 
 %i\n %a") ;; template

        

      ("c" "codeforces" ;; hotkey
       entry ;;type
       (file+headline org-default-notes-file "Problems")
       (file "~/Opensource/zotherstupidguy.github.io/org/templates/codeforces.orgcaptmpl")
       
      ))) ;; snip





;; Figure out what is a Journal and if it is a nice thing to turn my blog into a journal with timestamps or not?
;; ("j" "Journal entry" entry (file+datetree "~/org/journal.org") (file "~/.emacs.d/org~templates/journal.orgcaptmpl"))

;; TODO Select-from-list, use this to supercharge competitive programming practices.
;; %^{Tidbit type|quote|zinger|one-liner|textlet}
;; ("b" "Tidbit: quote, zinger, one-liner or textlet" entry
;;  (file+headline org-default-notes-file "Tidbits")
;;  (file "~/.emacs.d/org-templates/tidbit.orgcaptmpl")
;; )




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; How to make tabs :)
;; http://blog.binchen.org/posts/easy-indentation-setup-in-emacs-for-web-development.html 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; make tab key, insert tab in every mode
;; http://www.pement.org/emacs_tabs.htm#one_thing
;; http://emacs.stackexchange.com/questions/24351/how-to-make-tab-key-shift-test-after-cursor-in-evil-mode-insert-state
;; (global-set-key (kbd "C-i") 'self-insert-command); 
(setq-default indent-tabs-mode nil)
;;(define-key text-mode-map (kbd "<tab>") 'tab-to-tab-stop)
(define-key text-mode-map (kbd "C-i") 'tab-to-tab-stop)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
		      64 68 72 76 80 84 88 92 96 100 104 108 112
		      116 120))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;














;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; problems.el sourcecode here, should be extracted and deployed to MELPA or similar later on
;;; problems.el aims to interact with competitive programming websites and 
;; require restclient
;; very helpful emacsrocks video about restclient https://www.youtube.com/watch?v=fTvQTMOGJaw
;;(require 'restclient)
;; (defun json-read-file (file)
;; "Read the first JSON object contained in FILE and return it."
;; (with-temp-buffer
;; (insert-file-contents file)
;; (goto-char (point-min))
;;    (json-read)))

(require 'json)
;; (setq data (json-read-from-string " "))


;; this saves the restclient response with the extenstion .http, could be useful!
;; source: https://noahfrederick.com/log/restclient-for-emacs
;; (use-package restclient  :mode ("\\.http\\'" . restclient-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; problems.el ends here

;; show column number
(setq column-number-mode t)

;; truncate
;; (set-default 'truncate-lines t)

(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; (setq-default auto-fill-function 'do-auto-fill)

;; to scroll a single line at a time
(setq scroll-conservatively 9001)

;; highlight current line
;;(global-hl-line-mode t);


;;; .emacs ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-babel-eval-in-repl restclient yasnippet solarized-theme simpleclip seeing-is-believing ruby-test-mode ruby-electric robe restart-emacs quickrun pos-tip org-pomodoro org-page openwith mew magit latex-math-preview kooten-theme key-chord highlight-indentation git-timemachine git-auto-commit-mode flycheck evil-org ess elfeed csv-mode csv company color-theme chruby better-defaults avk-emacs-themes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; 
;; http://emacs.stackexchange.com/questions/28222/how-to-make-tab-work-in-org-mode-when-combined-with-evil-mode 
;;(evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)
;; (evil-define-key 'insert org-mode-map (kbd "<tab>") #'self-insert-command);


;; trying to fix tab in org-mode while in evil mode
;; http://stackoverflow.com/questions/22878668/emacs-org-mode-evil-mode-tab-key-not-working
;; (setq evil-want-C-i-jump nil)
;; (when evil-want-C-i-jump (define-key evil-motion-state-map (kbd "C-i") 'evil-jump-forward))

(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)
