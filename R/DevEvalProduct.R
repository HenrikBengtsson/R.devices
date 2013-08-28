###########################################################################/**
# @RdocClass DevEvalProduct
#
# @title "The DevEvalProduct class"
#
# \description{
#  @classhierarchy
#
#  A DevEvalProduct represents a handle to the "product" returned by
#  @see "devEval".
# }
#
# @synopsis
#
# \arguments{
#   \item{name, tags}{The name and optional tags of the product.}
#   \item{type}{The device type.}
#   \item{...}{Not used.}
# }
#
# \section{Fields and Methods}{
#  @allmethods
# }
#
# @author
#
# @keyword internal
#*/###########################################################################
setConstructorS3("DevEvalProduct", function(name=NULL, tags=NULL, type=NULL, ...) {
  if (!is.null(name)) {
    name <- Arguments$getCharacter(name);
    tags <- Arguments$getCharacters(tags);
    fullname <- paste(c(name, tags), collapse=",");
  } else {
    fullname <- NA_character_;
  }

  extend(BasicObject(fullname), "DevEvalProduct",
    type = type
  );
})

###########################################################################/**
# @RdocMethod as.character
# @alias as.character.DevEvalFileProduct
# @alias as.character
#
# @title "Gets a character representation of the product"
#
# \description{
#   @get "title".
# }
#
# @synopsis
#
# \arguments{
#  \item{...}{Not used.}
# }
#
# \value{
#   Returns a @character string.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("as.character", "DevEvalProduct", function(x, ...) {
  getFullname(x, ...);
}, private=TRUE)


###########################################################################/**
# @RdocMethod getFullname
# @alias getFullname.DevEvalFileProduct
# @aliasmethod getName
# @aliasmethod getTags
# @alias getFullname
# @alias getName
# @alias getTags
#
# @title "Gets the full name, name and tags"
#
# \description{
#   @get "title" consisting of a name and tags.
# }
#
# \usage{
# @usage "getFullname,DevEvalProduct"
# @usage "getFullname,DevEvalFileProduct"
# @usage "getName,DevEvalProduct"
# @usage "getTags,DevEvalProduct"
# }
#
# \arguments{
#  \item{...}{Not used.}
# }
#
# \value{
#   Returns a @character or a @character @vector.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getFullname", "DevEvalProduct", function(this, ...) {
  as.character(unclass(this), ...);
})


setMethodS3("getName", "DevEvalProduct", function(this, ...) {
  fullname <- getFullname(this, ...);
  parts <- unlist(strsplit(fullname, split=","), use.names=FALSE);
  name <- parts[1L];
  name;
})

setMethodS3("getTags", "DevEvalProduct", function(this, collapse=NULL, ...) {
  fullname <- getFullname(this, ...);
  parts <- unlist(strsplit(fullname, split=","), use.names=FALSE);
  tags <- parts[-1L];
  if (!is.null(collapse)) {
    tags <- paste(tags, collapse=collapse);
  }
  tags;
})

#########################################################################/**
# @RdocMethod getType
# @alias getType
#
# @title "Gets the type"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @character string or @NULL.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/#########################################################################
setMethodS3("getType", "DevEvalProduct", function(this, ...) {
  attr(this, "type");
})




###########################################################################/**
# @RdocClass DevEvalFileProduct
#
# @title "The DevEvalFileProduct class"
#
# \description{
#  @classhierarchy
#
#  A DevEvalFileProduct is a @see "DevEvalProduct" refering to a image
#  file created by @see "devEval".
# }
#
# @synopsis
#
# \arguments{
#   \item{filename, path}{The filename and the optional path of the image
#    file product.}
#   \item{...}{Additional arguments passed to @see "DevEvalProduct".}
# }
#
# \section{Fields and Methods}{
#  @allmethods
# }
#
# @author
#
# @keyword internal
#*/###########################################################################
setConstructorS3("DevEvalFileProduct", function(filename=NULL, path=NULL, ...) {
  if (!is.null(filename)) {
    pathname <- Arguments$getReadablePathname(filename, path=path, mustExist=FALSE);
    path <- dirname(pathname);
    filename <- basename(pathname);
  } else {
    pathname <- NA_character_;
  }

  this <- extend(DevEvalProduct(pathname, ...), "DevEvalFileProduct");

  # Infer 'type' from pathname?
  type <- getType(this);
  if (is.null(type) && !is.na(pathname)) {
    ext <- getExtension(this);
    type <- .devTypeName(ext);
    attr(this, "type") <- type;
  }

  this;
})

setMethodS3("as.character", "DevEvalFileProduct", function(x, ...) {
  getPathname(x, ...);
}, private=TRUE)


setMethodS3("getFullname", "DevEvalFileProduct", function(this, ...) {
  filename <- getFilename(this, ...);
  gsub("[.]([^.]*)$", "", filename);
})


###########################################################################/**
# @RdocMethod getPathname
# @aliasmethod getFilename
# @aliasmethod getPath
# @aliasmethod getExtension
# @alias getPathname
# @alias getFilename
# @alias getPath
# @alias getExtension
#
# @title "Gets the pathname, filename and path"
#
# \description{
#   @get "title".
# }
#
# \usage{
# @usage "getPathname,DevEvalFileProduct"
# @usage "getFilename,DevEvalFileProduct"
# @usage "getPath,DevEvalFileProduct"
# @usage "getExtension,DevEvalFileProduct"
# }
#
# \arguments{
#  \item{...}{Not used.}
# }
#
# \value{
#   Returns a @character string.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getPathname", "DevEvalFileProduct", function(this, ...) {
  as.character(unclass(this), ...);
})

setMethodS3("getFilename", "DevEvalFileProduct", function(this, ...) {
  basename(getPathname(this, ...));
})

setMethodS3("getPath", "DevEvalFileProduct", function(this, ...) {
  dirname(getPathname(this, ...));
})

setMethodS3("getExtension", "DevEvalFileProduct", function(this, ...) {
  filename <- getFilename(this, ...);
  gsub(".*[.]([^.]*)$", "\\1", filename);
}, private=TRUE)



#########################################################################/**
# @RdocMethod getMimeType
# @aliasmethod getMime
# @alias getMimeType
# @alias getMime
#
# @title "Gets the MIME type"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{default}{The value returned, if the MIME type could not be inferred.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @character string.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/#########################################################################
setMethodS3("getMimeType", "DevEvalFileProduct", function(this, default="", ...) {
  ext <- getExtension(this, ...);
  ext <- .devTypeName(ext);
  mimeTypes <- c(
    bmp="image/bmp",
    gif="image/gif",
    jpg="image/jpeg",
    pdf="application/pdf",
    eps="application/postscript",
    postscript="application/postscript",
    png="image/png",
    svg="image/svg+xml",
    tiff="image/tiff"
  )
  mime <- mimeTypes[ext];
  if (is.na(mime)) mime <- default;
  mime;
})

setMethodS3("getMime", "DevEvalFileProduct", function(this, ...) {
  getMimeType(this, ...);
}, private=TRUE)



#########################################################################/**
# @RdocMethod getDataURI
# @alias getDataURI
#
# @title "Gets a Base64-encoded data URI"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{mime}{The MIME type to be embedded in the data URI.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @character string.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/#########################################################################
setMethodS3("getDataURI", "DevEvalFileProduct", function(this, mime=getMimeType(this), ...) {
  base64enc::dataURI(file=getPathname(this), mime=mime, encoding="base64");
})



## setMethodS3("defaultField", "DevEvalProduct", function(this, default=getOption("devEval/args/field", "pathname"), ...) {
##   res <- attr(this, "defaultField", exact=TRUE);
##   if (is.null(res)) res <- default;
##   res;
## }, private=TRUE)
##
## setMethodS3("setDefault", "DevEvalProduct", function(x, value, ...) {
##   if (!is.null(value)) {
##     value <- Arguments$getCharacter(value);
##   }
##   attr(x, "defaultField") <- value;
##   invisible(x);
## }, private=TRUE)
##
## setMethodS3("getDefault", "DevEvalProduct", function(this, ...) {
##   field <- defaultField(this, ...);
##   if (is.null(field)) return(this);
##   # AD HOC: Workaround for internal protection of `[[.BasicObject`.
##   attr(this, "disableGetMethods") <- NULL;
##   this[[field]];
## }, private=TRUE)




############################################################################
# HISTORY:
# 2013-08-27
# o Added the DevEvalProduct and DevEvalFileProduct classes.
# o Created.
############################################################################
