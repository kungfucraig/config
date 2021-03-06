;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C++ Stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun cpp-source-file-header (fileName)
  (interactive "bBuffer Name: ")
  (shell-command
   (concat "cg.cmd cs -m classname="
           (if (or (string= (substring fileName -2) "qh")
                   (string= (substring fileName -2) "cc"))
               (substring fileName 0 -3)
               (substring fileName 0 -2))
           )
   1
   )
  )

(defun cpp-include-file-header (fileName)
  (interactive "bBuffer Name: ")
  (shell-command (concat "cg.cmd ch -m classname="
                         (if (string= (substring fileName -2) "qh")
                             (substring fileName 0 -3)
                           (substring fileName 0 -2))
                         )
                 1
                 )
  (beginning-of-buffer))

(defun cpp-function-header ()
  (interactive)
  (shell-command (concat "cg.cmd cf") 1))

(defun xml-file-header (fileName)
  (interactive "bBuffer Name: ")
  (shell-command (concat "cg.cmd xml -m filename=" fileName)
                 1 )
  (end-of-buffer))


;; Limitation here is that this only works with
;; files that have a two character extension.
(defun insert-classname ()
  (interactive)
  (let*
      ((path
    (split-string (buffer-file-name (current-buffer)) "/"))
       (filename (nth (- (length path) 1) path))
       (fileNoExt (split-string filename "\\."))
       )
    (insert (car fileNoExt))))


;; You should have the stl container
;; declaration string in register
;; 1
(defun stl-for-loop ()
  (interactive)
  (indent-according-to-mode)
  (let* (
         ;;(r1 (get-register 49))
         (r1 (car kill-ring))
         (sp (split-string r1))
    (type (car sp))
    (var (substring (cadr sp) 0 (- (length (cadr sp)) 1))))

    (indent-for-tab-command)
    (insert (concat "for ( " type "::iterator iter = " var ".begin();\n"))
    (indent-for-tab-command)
    (insert "iter != " var ".end();\n")
    (indent-for-tab-command)
    (insert "++iter )\n{")
    (indent-for-tab-command)
    (insert "\n\n}")
    (indent-for-tab-command)
    (previous-line 1)
    (indent-for-tab-command)
    ))


(defun add-data-class-function ()
  (interactive)
  (let* (
         ;;(r1 (get-register 49))
         (r1 (car kill-ring)))
    (search-backward ";")
    (search-backward ";")
    (search-backward "(")
    (backward-word 1)
    (let* ((startPoint (point)))
      (forward-word 1)
      (let ((endPoint (point)))
        (copy-to-register 9 startPoint endPoint)
        ))
    (let ((r9 (get-register 9)))
      (search-forward (concat "::" r9)))

    (search-forward "{")
    (end-of-defun)
    (insert "\n")
    (cpp-function-header)
    (insert r1)
    (beginning-of-line)
    (indent-for-tab-command)
    (forward-word 1)
    (forward-char 1)
    (insert-classname)
    (insert "::Data::")
    (end-of-line)
    (backward-delete-char-untabify 1)
    (insert "\n{\n\n}\n")
    (previous-line 2)
    (indent-for-tab-command)
    (inset "Result r;\n")
    (indent-for-tab-command)
    (insert (concat "const char* fname =\"" "\";\n"))
    (indent-for-tab-command)
    ))


(defun insert-success ()
  (interactive)
  (indent-for-tab-command)
  (insert "return Result(CMT_SUCCESS);"))

;; Don't use tabs, use spaces.
;;(setq indent-tabs-mode nil)

(setq prefixes '("C_" "W_" "KRN_"
                        "EVT_" "J_" "UTL_"
                        "Q" "ABS_" "CAD_" "EVT_"
                        "FLD_" "INR_" "SMT_" "PRO_" "SYC_"))

(setq my-c-style
      `(
        (c-cleanup-list . (scope-operator
                           empty-defun-braces
                           defun-close-semi))
        (c-offsets-alist . (
                            (arglist-close . c-lineup-arglist)
                            (arglist-cont-nonempty . c-lineup-arglist)
                            (inclass . ++)
                            (inline-open . 0)
                            (access-label . -)
                            (substatement-open . 0)
                            ))

        (c-access-key . "\\<\\(signals\\|\\(public\\|protected\\|private\\)\\([     ]+slots\\)?\\)\\>:")

        (c-protection-key . "\\<\\(public\\|public slot\\|protected\\|protected slot\\|private\\|private slot\\)\\>")
        (c-C++-access-key . "\\<\\(signals\\|public\\|protected\\|private\\|public slots\\|protected slots\\|private slots\\)\\>[ \t]*:")

        ;;,(append (mapcar (lambda (x) (concat x "_[^ :<(]*")) prefixes)
        ;; This is some CoMeT specific stuff.
        (c++-font-lock-extra-types . ,(append (mapcar (lambda (x) (concat x "[^ :<(]*")) prefixes) '("Data" "std::list" "std::set" "set::map" "std::multimap" "std::vector" "std::stack" "iterator" "const_iterator" "size_t")))

        (c-echo-syntactic-information-p . t )  ;; what's this do?
        ))

(add-hook
 'c-mode-common-hook
 (lambda ()
   (c-add-style "my-c-style" my-c-style t)

   ;; Set up some keys.
   (local-set-key "\C-c\C-f" 'cpp-function-header)
   (local-set-key "\C-c\C-j" 'insert-classname)
   (local-set-key "\C-c\C-l" 'stl-for-loop)
   (local-set-key "\C-cl" 'add-data-class-function)
   (local-set-key "\C-cs" 'insert-success)

   ;; These functions must be after the call to c-add-style.
   (setq c-basic-offset 3)
   ;; this seems to be key for "for loop" indenting
   (setq indent-tabs-mode nil)
   ;;(modify-syntax-entry ?_ "w")
))


(setq auto-mode-alist
      (append '(("\\.C\\'" . c++-mode)
                ("\\.cxx\\'" . c++-mode)
                ("\\.h\\'" . c++-mode)
                ("\\.hxx\\'" . c++-mode)
                ("\\.qh\\'" . c++-mode)
                ("\\.hpp\\'" . c++-mode)
                ("\\.cc\\'" . c++-mode)
                ("\\.c\\'" . c++-mode)
                ("\\.template\\'" . c++-mode))
              auto-mode-alist))


(defun insert-check-result ()
  (interactive)
  (insert "CHECK_RESULT_RETURN_ON_FAILURE(r);"))

(add-hook
 'c-mode-common-hook
 (lambda ()
   (local-set-key [f9] 'code-compile-buffer)
   (local-set-key "\C-c\C-r" 'insert-check-result)))
