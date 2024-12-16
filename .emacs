;; --- System --- ;;

;; Add MELPA to the default GNU package archive
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Warm up the beanshell when starting the emacs daemon, since it's expensive
;(require 'jdee)
;(require 'jdee-bsh)
;(when (daemonp)
;  (add-hook 'after-init-hook (lambda() (jdee-bsh-run))))

;; Kill the menu bar
(menu-bar-mode 0)

;; Make scrolling granular
(setq scroll-step 1)

;; Don't create backups on edit
(setq make-backup-files nil)

;; Kill scratch header
(setq initial-scratch-message nil)

;; Always display column numbers
(setq column-number-mode t)

;; Never indent with tabs (though some modes ignore this)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)

;; Set mode-specific tab widths
(setq js-indent-level 2)

;; Always enable whitespace-mode by default
;(global-whitespace-mode 1)

;; Enable whitespace-mode on LaTeX files
(defun latex-mode-setup () (whitespace-mode 1))
(add-hook 'latex-mode-hook 'latex-mode-setup)

;; Set style defaults for printing whitespace-mode marks as well as for cleanup.
;;
;; Cleanup erroneous whitespace in existing files, via `M-x whitespace-cleanup`:
;; - empty lines at beginning/end of file are removed
;; - indentation at beginning of line will convert to spaces
;; - mixing spaces and tabs will convert to spaces
;; - trailing whitespace at the end of a line is removed
(setq whitespace-style
  '(
    ;; Cleanup defaults
    empty
    indentation::space
    space-before-tab::space
    space-after-tab::space
    trailing
    ;; Printing defaults, remove highlighting on all whitespace glyhps
    spaces
    tabs
    newline
    space-mark
    tab-mark
    newline-mark
  )
)

;; Override marks used in whitespace-mode with ones easier to read
(setq whitespace-display-mappings
  ;; NOTE: The replacement values below are in unicode hex-codes,
  ;;       (insert-char 23ce) can be used to view a glyph.
  '(
    (space-mark 32 [#xB7])        ;; ·
    (newline-mark 10 [#x23CE 10]) ;; ⏎
    (tab-mark 9 [#x25B7 9])       ;; ▷
  )
)

;; Smartparen highlighting
(setq sp-highlight-pair-overlay nil)
(setq sp-highlight-wrap-overlay nil)

(use-package ellama
  :bind ("C-u" . ellama-transient-main-menu)
  :init
  (require 'llm-ollama)
  (setopt ellama-provider
	      (make-llm-ollama
	       :chat-model "llama3.1:8b-instruct-q8_0"
	       :embedding-model "nomic-embed-text"
	       :default-chat-non-standard-params '(("num_ctx" . 8192))))
  (setopt ellama-summarization-provider
	      (make-llm-ollama
	       :chat-model "qwen2.5:3b"
	       :embedding-model "nomic-embed-text"
	       :default-chat-non-standard-params '(("num_ctx" . 32768))))
  (setopt ellama-coding-provider
	      (make-llm-ollama
	       :chat-model "qwen2.5-coder:3b"
	       :embedding-model "nomic-embed-text"
	       :default-chat-non-standard-params '(("num_ctx" . 32768))))
  (setopt ellama-naming-provider
	      (make-llm-ollama
	       :chat-model "llama3.1:8b-instruct-q8_0"
	       :embedding-model "nomic-embed-text"
	       :default-chat-non-standard-params '(("stop" . ("\n")))))
  (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
  (setopt ellama-translation-provider
	      (make-llm-ollama
	       :chat-model "qwen2.5:3b"
	       :embedding-model "nomic-embed-text"
	       :default-chat-non-standard-params '(("num_ctx" . 32768))))
  ;; see M-x info > Elisp > Buffer Display Action Functions
  (setopt ellama-chat-display-action-function #'display-buffer-full-frame)
  (setopt ellama-instant-display-action-function #'display-buffer-at-bottom)
  :config
  (add-hook 'org-ctrl-c-ctrl-c-hook #'ellama-chat-send-last-message))


;; --- Initialization --- ;;

;; Load dired Workspace on startup
(setq dired-use-ls-dired nil)
(setq initial-buffer-choice "~/Workspace")

;; Kill Workspace buffer if a file is loaded from the shell
(defun no-initial-buffer ()
  (setq initial-buffer-choice nil))
(add-hook 'find-file-hook 'no-initial-buffer)


;; --- Global key bindings --- ;;

;; Traversing
(global-set-key (kbd "C-o") 'forward-word)
(global-set-key (kbd "C-n") 'backward-word)
(global-set-key (kbd "C-s") 'forward-paragraph)
(global-set-key (kbd "C-a") 'backward-paragraph)

;; Editing
(global-set-key (kbd "M-TAB") 'hippie-expand)
(global-set-key (kbd "M-SPC") 'set-mark-command)
(global-set-key (kbd "M-m"  ) 'kill-region)
(global-set-key (kbd "M-w"  ) 'kill-ring-save)
(global-set-key (kbd "M-v"  ) 'yank)


;; --- Modes --- ;;

(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

;; Java and JDEE
;
;(defun tab-autocomplete ()
;  (interactive)
;  (if (symbol-at-point)
;      (jdee-complete-in-line)
;      (c-indent-line-or-region)))
;
;(add-hook 'jdee-mode-hook
;          (lambda ()
;            (smartparens-mode)
;            (jdee-backend-launch) ;; Super expensive, best to --daemon emacs
;            (define-key (current-local-map) (kbd "M-TAB") 'jdee-complete-minibuf)
;            (define-key (current-local-map) (kbd "TAB") 'tab-autocomplete)
;            (define-key (current-local-map) (kbd "<f5>") 'jdee-compile)
;            (define-key (current-local-map) (kbd "<f6>") 'jdee-run)))



;; --- Autogenerated --- ;;
;; - do not edit below - ;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ; '(jdee-compile-enable-kill-buffer 2)
 ; '(jdee-compiler '("javac"))
 ; '(jdee-jdk-registry
 ;   '(("10.0" . "/Library/Java/JavaVirtualMachines/jdk-10.jdk/Contents/Home")))
 ; '(jdee-server-dir "/Users/amcnamara/.emacs.d/jdee-server/target")
 '(package-selected-packages
   '(ellama quelpa-leaf quelpa-use-package quelpa company jdee kotlin-mode devdocs smartparens)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
