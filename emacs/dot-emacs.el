;:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General Options
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)
(setq tab-width 3)
(setq make-backup-files nil)
(require 'font-lock)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(blink-cursor-mode 0)
(transient-mark-mode 1)
;;(tool-bar-mode 0)
(setq-default indent-tabs-mode nil)
(setq next-line-add-newlines nil)
(server-start)
(put 'set-goal-column 'disabled nil)
(setq visible-bell t)
(show-paren-mode t)
(blink-cursor-mode nil)
(column-number-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Terminal (tmux) mouse
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))
(setq mouse-sel-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Killing trailing white space after lines.
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ido
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Uniquify
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Map some keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key [f3] 'bookmark-bmenu-list)
(global-set-key [f4] 'bookmark-set)
(global-set-key [f6] 'copy-to-register)
(global-set-key [f7] 'insert-register)
;;(global-set-key [?\C-x?\h] 'eshell)
(global-set-key [?\C-x?\h] 'shell)
(global-set-key [?\C-x?\_] 'revert-buffer)
(global-set-key "\C-x\-" 'bury-buffer)
(global-set-key "\C-x\g" 'goto-line)
(global-set-key [?\M-n] 'scroll-up)
(global-set-key [?\M-p] 'scroll-down)
(global-set-key [C-kp-home] 'beginning-of-buffer)
(global-set-key [C-home] 'beginning-of-buffer)
(global-set-key [C-kp-end] 'end-of-buffer)
(global-set-key [C-end] 'end-of-buffer)

;; This needs to be set before we load evil.
(setq evil-want-C-i-jump nil)

;; Make * and # behave like vim.
(setq evil-symbol-word-search t)

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
