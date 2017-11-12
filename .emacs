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
                     ;;green-screen-theme
                     ;;green-phosphor-theme
                     ;;blue-mood
                     color-theme-modern		     
                     smart-compile 
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
                     ;;yasnippet           
                     inf-ruby
                     ess
                     flycheck
                     company ;; https://company-mode.github.io/
                     ;; magit ;; one-thing-per-commit
                     ;;magit-popup
                     git-timemachine ;; step forward and backward through the history of a file
                     highlight-indentation  ;;TODO require it and use it for python projects
                     openwith ;; open links for files and webpages into external programs 
                     robe ;; required for robe-mode-hook https://github.com/dgutov/robe
                     org-pomodoro ;; https://github.com/lolownia/org-pomodoro
                     pos-tip  ;; https://www.topbug.net/blog/2016/11/03/emacs-display-function-or-variable-information-near-point-cursor/
                     mew ;; email in emacs world 
                     elfeed  ;; emacs RSS
                     ;;restclient
                     ;;ob-restclient
                     ruby-test-mode
                     org-fstree
                     dash
                     dash-functional
                     s
                     origami
                     neotree
                     ;;vimish-fold
                     ;; pdf-tools ;; to read pdf. https://github.com/politza/pdf-tools  
                     ))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'better-defaults)

;; Making man pages friendly
;; M-x man 
(setenv "MANWIDTH" "72")

;;neotree
(require 'neotree)
(global-set-key [f2] 'neotree-toggle)
(setq neo-smart-open t)
(add-hook 'after-init-hook #'neotree-toggle)
(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))


;;(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
;;(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
;;(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
;;(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)

;; fold my codeblocks
(require 'origami)
(global-origami-mode 1)
;;(origami-close-all-nodes 1)
(global-set-key (kbd "C-c C-f") #'origami-show-only-node)

;;(require 'vimish-fold)
;;(vimish-fold-global-mode 1)
;;(global-set-key (kbd "C-c h h") #'vimish-fold)
;;(global-set-key (kbd "C-c f") #'vimish-fold-delete)
;;(global-set-key (kbd "C-c C-f") #'vimish-fold-toggle)

;; C-mode conf
;; https://truongtx.me/2013/03/10/emacs-setting-up-perfect-environment-for-cc-programming
(setq inhibit-splash-screen t
      initial-scratch-message nil
      ;; initial-major-mode 'ruby-mode)
      initial-major-mode 'c-mode)
(setq-default c-basic-offset 8 c-default-style "linux")
(setq-default tab-width 8 indent-tabs-mode t)

;; configs from smart-tab https://www.emacswiki.org/emacs/SmartTabs#toc8
;;(setq-default tab-width 4) ; or any other preferred value
(setq cua-auto-tabify-rectangles nil)
(defadvice align (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))
(defadvice align-regexp (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))
(defadvice indent-relative (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-according-to-mode (around smart-tabs activate)
  (let ((indent-tabs-mode indent-tabs-mode))
    (if (memq indent-line-function
              '(indent-relative
                indent-relative-maybe))
        (setq indent-tabs-mode nil))
    ad-do-it))
(defmacro smart-tabs-advice (function offset)
  `(progn
     (defvaralias ',offset 'tab-width)
     (defadvice ,function (around smart-tabs activate)
       (cond
        (indent-tabs-mode
         (save-excursion
           (beginning-of-line)
           (while (looking-at "\t*\\( +\\)\t+")
             (replace-match "" nil nil nil 1)))
         (setq tab-width tab-width)
         (let ((tab-width fill-column)
               (,offset fill-column)
               (wstart (window-start)))
           (unwind-protect
               (progn ad-do-it)
             (set-window-start (selected-window) wstart))))
        (t
         ad-do-it)))))
(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)
(smart-tabs-advice language-indent-line language-basic-offset)
;; end of smart-tab configs


;;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
;;; activate ecb
;;(require 'ecb)
;;(require 'ecb-autoloads)
;; ecb layouts
;; http://ecb.sourceforge.net/docs/Changing-the-ECB-layout.html
;;(setq ecb-layout-name "left-dir-plus-speedbar")
;;(setq ecb-layout-name "left-analyse")
;;(setq ecb-layout-name "left9")
;;(setq ecb-show-sources-in-directories-buffer 'always)
;;(setq ecb-compile-window-height 12)
;;(global-set-key (kbd "C-e") 'ecb-goto-window-edit1)
;;(global-set-key (kbd "C-d") 'ecb-goto-window-directories)
;;(global-set-key (kbd "C-s") 'ecb-goto-window-sources)
;;(global-set-key (kbd "C-m") 'ecb-goto-window-methods)
;;(global-set-key (kbd "C-c") 'ecb-goto-window-compilation)
;;(ecb-activate)
;;(setq enable-recursive-minibuffers t)
;;smart-compile
;;(add-to-list 'smart-compile-alist);; '(c-mode  . "gcc -O2 -Wall -o %n %f"))
;;("euler.*\\.[Cc]+[Pp]*$" . "g++ -O2 -Wall -pedantic -Werror -Wreturn-type %f -lm -lgmpxx -lgmp -o ../bin/%n && time ../bin/%n")
;;(global-set-key (kbd "C-c c") 'smart-compile)
(defun c ()
  (interactive)
  (smart-compile 1)
  )
(defun s ()
  (interactive)
  (ace-window 1)
  )
(add-hook 'c-mode-hook
          (lambda ()
            (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
(defun my-other-delete-trailing-blank-lines ()
  "Deletes all blank lines at the end of the file, even the last one"
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-max))
      (delete-blank-lines)
      (let ((trailnewlines (abs (skip-chars-backward "\n\t"))))
        (if (> trailnewlines 0)
            (progn
              (delete-char trailnewlines)))))))

;; https://github.com/emacs-jp/replace-colorthemes
(load-theme 'blue-mood t t)
(enable-theme 'blue-mood)


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


;; yasnippet, docs: http://joaotavora.github.io/yasnippet/
;;TODO create some custom org-snippet for note-taking
;;(require 'yasnippet)
;;(yas-global-mode 1)

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


;; Show line numbers
(global-linum-mode)
(setq linum-format "%d ")
(setq-default left-fringe-width  20)
;;(setq-default right-fringe-width  0)
;;(set-face-attribute 'fringe nil :background "yellow")



;; activate evil mode
(require 'evil)
(evil-mode 1)


;; EightyColumnRule
;; openbsd mailing list 72col rule
;; my own safe-side clean code 70col rule
;; https://www.emacswiki.org/emacs/EightyColumnRule
(add-hook 'text-mode-hook 'auto-fill-mode)
;;(setq-default fill-column 80)
(setq-default fill-column 70)
;; free of trailing whitespace and to use 80-column width, standard indentations
(require 'whitespace)
(setq whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab)
      ;;whitespace-line-column 80)
      whitespace-line-column 70)
;;(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)
(global-whitespace-mode +1)


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

;; M-x org-publish-project then Publish project: org
;; this publishes my project perfectly!
(require 'ox-publish)
(setq org-publish-project-alist
      '(
        ("org-notes"
         :base-directory "~/Opensource/zautomata.github.io/org"
         :base-extension "org"
         :publishing-directory  "~/Opensource/zautomata.github.io/public"
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

         (setf user-full-name "zautomata")
         (setf user-mail-address "zautomata@gmail.com")
         )

        ("org-static"
         :base-directory "~/Opensource/zautomata.github.io/org"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory  "~/Opensource/zautomata.github.io/public"
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
(setq org-default-notes-file "~/Opensource/zautomata.github.io/org/index.org")

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
         (file "~/Opensource/zautomata.github.io/org/templates/codeforces.orgcaptmpl")

         ))) ;; snip


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


;; show column number
(setq column-number-mode t)

;; truncate
;; (set-default 'truncate-lines t)

(add-hook 'text-mode-hook 'turn-on-auto-fill)


;; to scroll a single line at a time
(setq scroll-conservatively 9001)

;; This instructs emacs to store the auto-saves inside the auto-save folder in the user-emacs-directory (usually ~/.emacs.d).
;;(setq auto-save-file-name-transforms
;;                `((".*" ,(concat user-emacs-directory "auto-save/") t))) 

;; emacs font
;;(set-frame-font "Inconsolata-18"); use ibm
;; server-start 
;;(server-start)
(split-window-horizontally)

;; knf starts

;;
;; OpenBSD KNF style
;;
;; Copyright (c) 2014,2015 Doug Hogan <doug@openbsd.org>
;; Copyright (c) 2005 Nicholas Marriott <nicm@openbsd.org>
;;
;; Permission to use, copy, modify, and distribute this software for any
;; purpose with or without fee is hereby granted, provided that the above
;; copyright notice and this permission notice appear in all copies.
;;
;; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
;; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
;; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
;; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
;; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
;; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
;; OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
;;

;; This function is from nicm@
(defun openbsd-knf-space-indent (langelem)
  "Indents either 4 spaces or none.

  This function is from nicm@ and also in gsoares@'s config.
  Most useful with c-offset-alist entries that are lists such as
  arglist-cont-nonempty"
  (save-excursion
    (goto-char (cdr langelem))
    (setq syntax (car (car (c-guess-basic-syntax))))
    (while (or (eq syntax 'arglist-intro)
               (or (eq syntax 'arglist-cont)
                   (eq syntax 'arglist-cont-nonempty)))
      (forward-line -1)
      (setq syntax (car (car (c-guess-basic-syntax)))))
    (beginning-of-line)
    (re-search-forward "[^ \t]" (c-point 'eol))
    (goto-char (+ (match-beginning 0) 4))
    (vector (current-column))))

;; OpenBSD KNF that doug@ uses.
(defconst openbsd-knf-style
  '(
    ;; Debugging
    ;; (c-echo-syntactic-information-p . t) ;; display C-c C-s when hit 'tab'
    ;;
    ;; General settings that should be enabled in c-mode
    (indent-tabs-mode . t)      ;; use tabs whenever feasible
    (fill-column . 80)          ;; Assume KNF tries to maintain 80 char lines
    (show-trailing-whitespace . t)  ;; KNF says to not have trailing WS
    (tab-width . 8)             ;; When displaying literal tab, show 8 spaces
    ;; c-mode
    (c-progress-interval . 1)   ;; display progress meter during long indents
    (c-basic-offset . 8)        ;; KNF uses 8 space tabs
    (c-comment-only-line-offset . 0)  ;; don't indent comments extra
    (c-backspace-function . delete-backward-char)
    (c-delete-function . delete-char)
    (c-syntactic-indentation-in-macros . t) ;; indent inside macro defs
    (c-tab-always-indent . t)  ;; indent line: Use C-q 'tab' to insert literal
    (c-continued-statement-offset 0)
    ;; (c-electric-flag . nil)   ;; if you don't like auto-indent
    (c-electric-continued-statement . t)
    ;;
    (c-indent-comments-syntactically-p . nil)
    ;;
    ;; Offsets for the various c-mode symbols.  Offsets are sometimes based
    ;; upon other offsets.  For instance, arglist-intro is the 1st argument
    ;; line.  If you define arglist-cont, it uses arglist-intro plus that.
    ;; c-echo-syntactic-information-p is your friend when debugging indents.
    ;;
    ;; [N] means absolute column.  All the others are relative.
    ;;  0 = no extra indentation.  For literal column 0, use [0]
    ;;  N = extra N spaces.  For literal column N, use [N]
    ;; ++ = c-basic-offset * 2
    ;; -- = c-basic-offset * -2
    ;;  + = c-basic-offset * 1
    ;;  - = c-basic-offset * -1
    ;;  * = c-basic-offset * 0.5
    ;;  / = c-basic-offset * -0.5
    (c-offsets-alist . (
                        ;; Literal symbols
                        (func-decl-cont . 0)        ; C++ style func mod
                        (block-open . 0)            ; '{' for block
                        (label . [1])               ; goto label in column 1
                        (comment-intro . 0)         ; C comment
                        (cpp-macro . [0])           ; #define in column 0
                        ;; Multiline macro symbols
                        (cpp-define-intro . [0])    ; first list = column 0
                        (cpp-macro-cont . +)        ; add'l lines in macro
                        ;; Function symbols
                        (defun-open . 0)            ; '{' alone for func
                        (defun-close . 0)           ; '}' alone for func
                        (defun-block-intro . +)     ; first line of func
                        (topmost-intro . 0)         ; outermost part
                        (topmost-intro-cont . 0)    ; outermost part cont
                        (statement . 0)             ; func stmt (already off)
                        ;; XXX statement-cont should be 4 unless
                        ;; it is part of a macro, then 8.
                        (statement-cont . *)        ; continue stmt
                        ;; Class symbols.  XXX Should add support since there
                        ;; is a little C++ in the tree (GNU)
                        ;; Java
                        ;; K&R
                        (knr-argdecl-intro . +)     ; rare K&R (from KNF)
                        (knr-argdecl . 0)           ; add'l indent for rest
                        ;; Conditional construct symbols
                        (block-close . 0)           ; '}' for block
                        (statement-block-intro . +) ; stmt in loop/cond
                        (substatement . +)          ; non-braced stmt if()
                        (substatement-open . 0)     ; '{' in loop/cond
                        (substatement-label . [1])  ; goto label in loop/cond
                        (do-while-closure . 0)      ; 'while' alone in 'do'
                        (else-clause . 0)           ; 'else' when not nested
                        ;; Brace list symbols
                        (brace-list-close . 0)      ; enum/agg list close
                        (brace-list-intro . +)      ; 1st line of enum/agg
                        (brace-list-entry . 0)      ; add'l indent for entries
                        (brace-list-open . 0)       ; enum/agg init open
                        ;; Switch statement symbols
                        (statement-case-open . +)   ; '{' in case
                        (statement-case-intro . +)  ; 1st line in case stmt
                        (case-label . 0)            ; case label in switch
                        ;; Paren list symbols
                        ;; XXX This is typically a list so need to handle it
                        ;; differently from the rest.  Emacs adds the indents.
                        (arglist-intro . openbsd-knf-space-indent) ; 1st line
                        (arglist-cont . openbsd-knf-space-indent)
                        (arglist-cont-nonempty . openbsd-knf-space-indent)
                        (arglist-close . 0)         ; ')' alone
                        ;; External scope symbols
                        (extern-lang-open . [0])    ; '{' alone in 'extern C'
                        (extern-lang-close . [0])   ; '}' alone in 'extern C'
                        (inextern-lang . +)         ; lines inside 'extern C'
                        ;; Statement block
                        (inexpr-statement . +)))    ; gcc extension stmt expr
    ;; If not specified, the default is "before after".  All variables are
    ;; defined here.
    (c-hanging-braces-alist . (
                               ;; All variables
                               (defun-open before after)  ; function, enum
                               (defun-close before after) ; function
                               (class-open after) ; struct too
                               (class-close before after)
                               (inline-open after)
                               (inline-close before after)
                               (block-open after)
                               (block-close . c-snug-do-while)
                               (statement-cont after)
                               (substatement-open after)
                               (statement-case-open before after)
                               (brace-list-open after)
                               (brace-list-close before close)
                               (brace-list-intro after)
                               (brace-entry-open after)
                               (extern-lang-open after)
                               (extern-lang-close before after)
                               (namespace-open after)           ;; C++
                               (namespace-close before afetr)   ;; C++
                               (module-open after)              ;; CORBA
                               (module-close before after)      ;; CORBA
                               (composition-open after)         ;; CORBA
                               (composition-close before after) ;; CORBA
                               (inexpr-class-open after)
                               (inexpr-class-close before after)
                               (arglist-cont-nonempty before after)))
    ;; Whether to auto-insert newline before/after colon
    (c-hanging-colons-alist . ((case-label after)
                               (label after)
                               (access-label after)  ;; C++
                               (member-init-intro before)
                               (inher-intro)))
    ;; Whether to insert newlines after ';' or ','
    (c-hanging-semi&comma-criteria . (
                                      ;; supress newline when next line non-blank
                                      c-semi&comma-no-newlines-before-nonblanks
                                      ;; suppress newline in paren (for loop etc)
                                      c-semi&comma-inside-parenlist
                                      ;; supress newline for one liner
                                      c-semi&comma-no-newlines-for-oneline-inliners))
    ;; When autonewline mode is enabled, clean up some extra newlines
    (c-cleanup-list . (brace-else-brace    ; } else {
                       brace-elseif-brace  ; } else if {
                       brace-catch-brace   ; } catch (...) {
                       ;; empty-defun-braces ; {} instead of multiple lines
                       defun-close-semi    ; struct: no \n between '}' and ';'
                       list-close-comma    ; remove final comma
                       scope-operator
                       ;; space-before-funcall ; GNU standard
                       ;; compact-empty-funcall ; another GNU standard
                       ;; comment-close-slash ; term comment with slash
                       ))
    ))

(defun openbsd-set-knf-style ()
  "Set OpenBSD style in a 'c-mode-common-hook'.
  Or interactively enable it in a buffer."
  (interactive)
  (c-add-style "OpenBSD" openbsd-knf-style t))

(provide 'openbsd-knf-style)

;; Start firing things up
;; OpenBSD KNF for C/C++
;;(require 'openbsd-knf-style)
(c-add-style "OpenBSD" openbsd-knf-style)
(setq c-default-style '((c-mode . "OpenBSD")))

;; knf ends 


;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (neotree origami s dash-functional org-fstree ruby-test-mode elfeed mew pos-tip org-pomodoro robe openwith highlight-indentation git-timemachine company flycheck ess inf-ruby seeing-is-believing ruby-electric restart-emacs key-chord evil smart-compile color-theme-modern better-defaults)))
 '(safe-local-variable-values
   (quote
    ((eval progn
           (c-set-style "stroustrup")
           (c-set-offset
            (quote innamespace)
            0))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
