(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))


;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head
      (concat
       "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />\n"
       "<style>pre.src { background: #343131; color: white; }</style>\n"))

;; org-html-head
;; (concat
;;  "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/css/htmlize.css\" />\n"
;;  "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/css/readtheorg.css\" />\n"
;;  "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/css/hideshow.css\" />\n"
;;  "<script type=\"text/javascript\" src=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/js/jquery-1.11.0.min.js\"></script>\n"
;;  "<script type=\"text/javascript\" src=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/js/jquery-ui-1.10.2.min.js\"></script>\n"
;;  "<script type=\"text/javascript\" src=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/js/jquery.localscroll-min.js\"></script>\n"
;;  "<script type=\"text/javascript\" src=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/js/jquery.scrollTo-1.4.3.1-min.js\"></script>\n"
;;  "<script type=\"text/javascript\" src=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/js/jquery.zclip.min.js\"></script>\n"
;;  "<script type=\"text/javascript\" src=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/js/readtheorg.js\"></script>\n"
;;  "<script type=\"text/javascript\" src=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/js/hideshow.js\"></script>\n"
;;  "<script type=\"text/javascript\" src=\"https://fniessen.github.io/org-html-themes/src/lib/js/jquery.stickytableheaders.min.js\"></script>\n"
;;  "<style>pre.src { background: #343131; color: white; }</style>\n"))


(setq org-html-preamble
      "<nav class=\"navbar navbar-expand-lg navbar-light bg-light\">
         <div class=\"container-fluid\">
           <a class=\"button\" href=\"index.html\">Home</a>
         </div>
       </nav>")


;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil           ;; Don't include author name
             :with-creator nil            ;; Include Emacs and Org versions in footer
             :with-toc t                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil)
       ;; Publish images (and other static files)
       (list "org-site:static"
             :recursive t
             :base-directory "./content/images"
             :publishing-directory "./public/images"
             :base-extension "png\\|jpg\\|jpeg\\|gif\\|svg"
             :publishing-function 'org-publish-attachment)))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
