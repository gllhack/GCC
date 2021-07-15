!{ dg-do run { target fd_truncate } }
! Tests character delimiters for namelist write 
! provided by Paul Thomas - pault@gcc.gnu.org

program namelist_18
  character*3        ::   ch = "foo"
  character*80       ::   buffer
  namelist /mynml/ ch

  open (10, status = "scratch")
  write (10, mynml)
  rewind (10)
  read (10, '(a)', iostat = ier) buffer
  read (10, '(a)', iostat = ier) buffer
  if (ier .ne. 0) call abort ()
  close (10)
  If ((buffer(6:6) /= "f") .or. (buffer(9:9) /= """")) call abort () 

  open (10, status = "scratch", delim ="quote")
  write (10, mynml)
  rewind (10)
  read (10, '(a)', iostat = ier) buffer
  read (10, '(a)', iostat = ier) buffer
  if (ier .ne. 0) call abort ()
  close (10)
  If ((buffer(5:5) /= """") .or. (buffer(9:9) /= """")) call abort ()

  open (10, status = "scratch", delim ="apostrophe")
  write (10, mynml)
  rewind (10)
  read (10, '(a)', iostat = ier) buffer
  read (10, '(a)', iostat = ier) buffer
  if (ier .ne. 0) call abort ()
  close (10)
  If ((buffer(5:5) /= "'") .or. (buffer(9:9) /= "'")) call abort ()

end program namelist_18