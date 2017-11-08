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

<<<<<<< HEAD
;; This instructs emacs to store the auto-saves inside the auto-save folder in the user-emacs-directory (usually ~/.emacs.d).
;;(setq auto-save-file-name-transforms
;;                `((".*" ,(concat user-emacs-directory "auto-save/") t))) 
=======
;; This instructs emacs to store the auto-saves inside the auto-save folder in
;; the user-emacs-directory (usually ~/.emacs.d).
;; (setq auto-save-file-name-transforms
;; `((".*" ,(concat user-emacs-directory "auto-save/") t))) 
>>>>>>> 9d7fa4f63fd852e17a211c0b838686404a1e39f2

;; emacs font
;;(set-frame-font "Inconsolata-18"); use ibm
;; server-start 
;;(server-start)
(split-window-horizontally)

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
