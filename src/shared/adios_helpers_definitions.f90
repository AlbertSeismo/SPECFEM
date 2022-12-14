!=====================================================================
!
!               S p e c f e m 3 D  V e r s i o n  3 . 0
!               ---------------------------------------
!
!     Main historical authors: Dimitri Komatitsch and Jeroen Tromp
!                              CNRS, France
!                       and Princeton University, USA
!                 (there are currently many more authors!)
!                           (c) October 2017
!
! This program is free software; you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation; either version 3 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License along
! with this program; if not, write to the Free Software Foundation, Inc.,
! 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
!
!=====================================================================

!===============================================================================
!> Helpers to set up adios features.
!! * Scalar definition
!! * Global arrays definition
!!
!! \author MPBL
!-------------------------------------------------------------------------------
module adios_helpers_definitions_mod

  implicit none

  private

  public :: define_adios_scalar
  public :: define_adios_global_real_1d_array
  public :: define_adios_global_double_1d_array
  public :: define_adios_global_integer_1d_array
  public :: define_adios_global_long_1d_array
  public :: define_adios_global_logical_1d_array
  public :: define_adios_global_string_1d_array
  public :: define_adios_local_string_1d_array
  public :: define_adios_global_array1D

  ! Generic interface to define scalar variables in ADIOS
  interface define_adios_scalar
    module procedure define_adios_double_scalar
    module procedure define_adios_float_scalar
    module procedure define_adios_integer_scalar
    module procedure define_adios_long_scalar
    module procedure define_adios_byte_scalar
  end interface define_adios_scalar

  interface define_adios_global_real_1d_array
    module procedure define_adios_global_1d_real_1d
    ! unused so far...
    !module procedure define_adios_global_1d_real_2d
    !module procedure define_adios_global_1d_real_3d
    !module procedure define_adios_global_1d_real_4d
    !module procedure define_adios_global_1d_real_5d
  end interface define_adios_global_real_1d_array

  interface define_adios_global_double_1d_array
    module procedure define_adios_global_1d_double_1d
    ! unused so far..
    !module procedure define_adios_global_1d_double_2d
    !module procedure define_adios_global_1d_double_3d
    !module procedure define_adios_global_1d_double_4d
    !module procedure define_adios_global_1d_double_5d
  end interface define_adios_global_double_1d_array

  interface define_adios_global_integer_1d_array
    module procedure define_adios_global_1d_int_1d
    ! unused so far..
    !module procedure define_adios_global_1d_int_2d
    !module procedure define_adios_global_1d_int_3d
    !module procedure define_adios_global_1d_int_4d
    !module procedure define_adios_global_1d_int_5d
  end interface define_adios_global_integer_1d_array

  interface define_adios_global_long_1d_array
    module procedure define_adios_global_1d_long_1d
    ! unused so far..
    !module procedure define_adios_global_1d_long_2d
    !module procedure define_adios_global_1d_long_3d
    !module procedure define_adios_global_1d_long_4d
    !module procedure define_adios_global_1d_long_5d
  end interface define_adios_global_long_1d_array

  interface define_adios_global_logical_1d_array
    module procedure define_adios_global_1d_logical_1d
    ! unused so far..
    !module procedure define_adios_global_1d_logical_2d
    !module procedure define_adios_global_1d_logical_3d
    !module procedure define_adios_global_1d_logical_4d
    !module procedure define_adios_global_1d_logical_5d
  end interface define_adios_global_logical_1d_array

  interface define_adios_global_string_1d_array
    module procedure define_adios_global_1d_string_1d
  end interface define_adios_global_string_1d_array

  interface define_adios_local_string_1d_array
    module procedure define_adios_local_1d_string_1d
  end interface define_adios_local_string_1d_array

  ! Cannot include an interface in another interface
  interface define_adios_global_array1D
    module procedure define_adios_global_1d_int_1d
    module procedure define_adios_global_1d_int_2d
    module procedure define_adios_global_1d_int_3d
    module procedure define_adios_global_1d_int_4d
    module procedure define_adios_global_1d_int_5d

    module procedure define_adios_global_1d_long_1d
    module procedure define_adios_global_1d_long_2d
    module procedure define_adios_global_1d_long_3d
    module procedure define_adios_global_1d_long_4d
    module procedure define_adios_global_1d_long_5d

    module procedure define_adios_global_1d_logical_1d
    module procedure define_adios_global_1d_logical_2d
    module procedure define_adios_global_1d_logical_3d
    module procedure define_adios_global_1d_logical_4d
    module procedure define_adios_global_1d_logical_5d

    module procedure define_adios_global_1d_real_1d
    module procedure define_adios_global_1d_real_2d
    module procedure define_adios_global_1d_real_3d
    module procedure define_adios_global_1d_real_4d
    module procedure define_adios_global_1d_real_5d

    module procedure define_adios_global_1d_double_1d
    module procedure define_adios_global_1d_double_2d
    module procedure define_adios_global_1d_double_3d
    module procedure define_adios_global_1d_double_4d
    module procedure define_adios_global_1d_double_5d

    module procedure define_adios_global_1d_string_1d

  end interface define_adios_global_array1D

contains

!===============================================================================
!> Define an ADIOS scalar double precision variable and autoincrement
!! the adios group size by (8).
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param path The logical path structuring the data and containing
!!             the variable
!! \param name The variable name in the ADIOS file.
!! \param var The variable to be defined. Used for type inference. Can be
!!            ignored.
!!
!! \note 'name' and 'var' are written as successive arguments on purpose.
!!       One should be able to define a macro such as:
!!       #define STRINGIFY_VAR(x) #x, x
!!       Calling define_adios_double_scalar with such a macro will be done as:
!!       call define_adios_double_scalar(group, size, path, STRINGIFY_VAR(x))
!!       as STRINGIFY_VAR(x) expand as:
!!       "x", x
!!       x being the variable name inside the code.

  subroutine define_adios_double_scalar (adios_group, group_size_inc, path, name, var)

  use adios_write_mod, only: adios_define_var,adios_double

  implicit none
  ! Arguments
  integer(kind=8),  intent(in)    :: adios_group
  integer(kind=8),  intent(inout) :: group_size_inc
  character(len=*), intent(in)    :: name, path
  real(kind=8),     intent(in)    :: var
  ! Local Variables
  integer(kind=8)                  :: varid ! dummy variable, adios use var name
  real(kind=8) :: idummy

  ! check
  if (len_trim(name) == 0) stop 'Error adios: invalid name in define_adios_scalar_double()'

  ! adios: 6 == real(kind=8)
  call adios_define_var (adios_group, trim(name), trim(path), adios_double,  '', '', '', varid)

  group_size_inc = group_size_inc + 8

  ! to avoid compiler warnings
  idummy = var

  end subroutine define_adios_double_scalar


!===============================================================================
!> Define an ADIOS scalar single precision variable and autoincrement
!! the adios group size by (8).
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param path The logical path structuring the data and containing
!!             the variable
!! \param name The variable name in the ADIOS file.
!! \param var The variable to be defined. Used for type inference. Can be
!             ignored.
!!
!! \note See define_adios_double_scalar()
  subroutine define_adios_float_scalar(adios_group, group_size_inc, path, name, var)

  use adios_write_mod, only: adios_define_var,adios_real

  implicit none
  ! Arguments
  integer(kind=8),  intent(in)    :: adios_group
  integer(kind=8),  intent(inout) :: group_size_inc
  character(len=*), intent(in)    :: name, path
  real(kind=4),     intent(in)    :: var
  ! Local Variables
  integer(kind=8)                 :: varid ! dummy variable, adios use var name
  real(kind=4) :: idummy

  ! check
  if (len_trim(name) == 0) stop 'Error adios: invalid name in define_adios_scalar_float()'

  ! adios: 5 == real
  call adios_define_var (adios_group, trim(name), trim(path), adios_real,  '', '', '', varid)

  group_size_inc = group_size_inc + 4

  ! to avoid compiler warnings
  idummy = var

  end subroutine define_adios_float_scalar


!===============================================================================
!> Define an ADIOS scalar integer variable and autoincrement the adios
!! group size by (4).
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param path The logical path structuring the data and containing
!!             the variable
!! \param name The variable name in the ADIOS file.
!! \param var The variable to be defined. Used for type inference. Can be
!             ignored.
!!
!! \note See define_adios_double_scalar()
  subroutine define_adios_integer_scalar(adios_group, group_size_inc, path, name, var)

  use adios_write_mod, only: adios_define_var,adios_integer

  implicit none
  ! Arguments
  integer(kind=8),  intent(in)     :: adios_group
  character(len=*), intent(in)     :: name, path
  integer(kind=8),  intent(inout)  :: group_size_inc
  integer(kind=4),     intent(in)  :: var
  ! Local Variables
  integer(kind=8)                  :: varid ! dummy variable, adios use var name
  ! Local vars
  !character(len=256) :: full_name
  integer(kind=4) :: idummy

  ! check
  if (len_trim(name) == 0) stop 'Error adios: invalid name in define_adios_scalar_integer()'

  !full_name = trim(path) // trim(name)

  ! adios: 2 ~ integer(kind=4)
  call adios_define_var (adios_group, trim(name), trim(path), adios_integer, '', '', '', varid)

  group_size_inc = group_size_inc + 4

  ! to avoid compiler warnings
  idummy = var

  end subroutine define_adios_integer_scalar

!===============================================================================
!> Define an ADIOS scalar long integer variable and autoincrement the adios
!! group size by (8).
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param path The logical path structuring the data and containing
!!             the variable
!! \param name The variable name in the ADIOS file.
!! \param var The variable to be defined. Used for type inference. Can be
!             ignored.
!!
!! \note See define_adios_double_scalar()
  subroutine define_adios_long_scalar(adios_group, group_size_inc, path, name, var)

  use adios_write_mod, only: adios_define_var,adios_long

  implicit none
  ! Arguments
  integer(kind=8),  intent(in)     :: adios_group
  character(len=*), intent(in)     :: name, path
  integer(kind=8),  intent(inout)  :: group_size_inc
  integer(kind=8),  intent(in)     :: var
  ! Local Variables
  integer(kind=8)                  :: varid ! dummy variable, adios use var name
  ! Local vars
  !character(len=256) :: full_name
  integer(kind=4) :: idummy

  ! check
  if (len_trim(name) == 0) stop 'Error adios: invalid name in define_adios_scalar_long()'

  !full_name = trim(path) // trim(name)

  ! adios: integer(kind=8)
  call adios_define_var (adios_group, trim(name), trim(path), adios_long, '', '', '', varid)

  group_size_inc = group_size_inc + 8

  ! to avoid compiler warnings
  idummy = var

  end subroutine define_adios_long_scalar



!===============================================================================
!> Define an ADIOS scalar byte variable and autoincrement the adios
!! group size by (1).
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param path The logical path structuring the data and containing
!!             the variable
!! \param name The variable name in the ADIOS file.
!! \param var The variable to be defined. Used for type inference. Can be
!             ignored.
!!
!! \note See define_adios_double_scalar()
  subroutine define_adios_byte_scalar (adios_group, group_size_inc, name, path, var)

  use adios_write_mod, only: adios_define_var,adios_byte

  implicit none
  ! Arguments
  integer(kind=8),  intent(in)     :: adios_group
  character(len=*), intent(in)     :: name, path
  integer(kind=8),  intent(inout)  :: group_size_inc
  ! note: byte is non-standard gnu Fortran
  !byte,     intent(in)             :: var
  integer(kind=1),  intent(in)     :: var
  ! Local Variables
  integer(kind=8)                  :: varid ! dummy variable, adios use var name
  integer(kind=1) :: idummy

  ! check
  if (len_trim(name) == 0) stop 'Error adios: invalid name in define_adios_scalar_byte()'

  ! adios: 0 == byte == any_data_type(kind=1)
  call adios_define_var (adios_group, trim(name), trim(path), adios_byte,  '', '', '', varid)

  group_size_inc = group_size_inc + 1

  ! to avoid compiler warnings
  idummy = var

  end subroutine define_adios_byte_scalar


!===============================================================================
!> Define the dimensions that will be written along a global array in ADIOS.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param local_dim The local dimension of the array.
  subroutine define_adios_global_dims_1d(adios_group, group_size_inc, array_name, local_dim)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc

  ! array_name should be defined
  if (len_trim(array_name) == 0) stop 'Error adios: invalid array_name in define_adios_global_dims_1d()'

  ! uses local_dim as dummy variable
  call define_adios_scalar (adios_group, group_size_inc, trim(array_name), "local_dim", local_dim)  ! scalar long type
  call define_adios_scalar (adios_group, group_size_inc, trim(array_name), "global_dim", local_dim)
  call define_adios_scalar (adios_group, group_size_inc, trim(array_name), "offset", local_dim)

  end subroutine define_adios_global_dims_1d


!===============================================================================
!> Define a real global array in ADIOS regardless of the array shape
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param local_dim The local dimension of the array.
  subroutine define_adios_global_1d_real_generic(adios_group, group_size_inc, array_name, local_dim)

  use adios_write_mod, only: adios_define_var,adios_real

  implicit none

  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  ! Variables
  integer(kind=8) :: var_id

  ! Define the dimensions of the array. local_dim used as a dummy
  ! variable to call the integer routine.
  call define_adios_global_dims_1d(adios_group, group_size_inc, trim(array_name), local_dim)

  call adios_define_var(adios_group, "array", trim(array_name), adios_real, &
                        trim(array_name) // "/local_dim", &
                        trim(array_name) // "/global_dim", &
                        trim(array_name) // "/offset", var_id)

  group_size_inc = group_size_inc + local_dim * 4

  end subroutine define_adios_global_1d_real_generic

!===============================================================================
!> Define a global ADIOS 1D real array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_real_1d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  real, dimension(:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_real_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_real_1d


!===============================================================================
!> Define a global ADIOS 1D real array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_real_2d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  real, dimension(:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_real_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_real_2d


!===============================================================================
!> Define a global ADIOS 1D real array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_real_3d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  real, dimension(:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_real_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_real_3d


!===============================================================================
!> Define a global ADIOS 1D real array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_real_4d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  real, dimension(:,:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

!print *,'debug: 1d_real_4d ',myrank,trim(full_name),local_dim,group_size_inc,adios_group

  call define_adios_global_1d_real_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_real_4d


!===============================================================================
!> Define a global ADIOS 1D real array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_real_5d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  real, dimension(:,:,:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_real_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_real_5d


!===============================================================================
!> Define a double global array in ADIOS regardless of the array shape
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param local_dim The local dimension of the array.
  subroutine define_adios_global_1d_double_generic(adios_group, group_size_inc, array_name, local_dim)

  use adios_write_mod, only: adios_define_var,adios_double

  implicit none

  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  ! Variables
  integer(kind=8) :: var_id

  ! Define the dimensions of the array. local_dim used as a dummy
  ! variable to call the integer routine.
  call define_adios_global_dims_1d(adios_group, group_size_inc, trim(array_name), local_dim)

  call adios_define_var(adios_group, "array", trim(array_name), adios_double, &
                        trim(array_name) // "/local_dim", &
                        trim(array_name) // "/global_dim", &
                        trim(array_name) // "/offset", var_id)

  group_size_inc = group_size_inc + local_dim * 8

  end subroutine define_adios_global_1d_double_generic

!===============================================================================
!> Define a global ADIOS 1D double array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_double_1d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  real(kind=8), dimension(:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_double_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_double_1d


!===============================================================================
!> Define a global ADIOS 1D double array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_double_2d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  real(kind=8), dimension(:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_double_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_double_2d


!===============================================================================
!> Define a global ADIOS 1D double array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_double_3d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  real(kind=8), dimension(:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_double_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_double_3d


!===============================================================================
!> Define a global ADIOS 1D double array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_double_4d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  real(kind=8), dimension(:,:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_double_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_double_4d


!===============================================================================
!> Define a global ADIOS 1D double array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_double_5d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  real(kind=8), dimension(:,:,:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_double_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_double_5d


!===============================================================================
!> Define a integer global array in ADIOS regardless of the array shape
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param local_dim The local dimension of the array.
  subroutine define_adios_global_1d_int_generic(adios_group, group_size_inc, array_name, local_dim)

  use adios_write_mod, only: adios_define_var,adios_integer

  implicit none

  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  ! Variables
  integer(kind=8) :: var_id

  ! Define the dimensions of the array. local_dim used as a dummy
  ! variable to call the integer routine.
  call define_adios_global_dims_1d(adios_group, group_size_inc, trim(array_name), local_dim)

  call adios_define_var(adios_group, "array", trim(array_name), adios_integer, &
                        trim(array_name) // "/local_dim", &
                        trim(array_name) // "/global_dim", &
                        trim(array_name) // "/offset", var_id)

  group_size_inc = group_size_inc + local_dim * 4

  end subroutine define_adios_global_1d_int_generic

!===============================================================================
!> Define a global ADIOS 1D int array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_int_1d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  integer(kind=4), dimension(:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_int_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_int_1d


!===============================================================================
!> Define a global ADIOS 1D int array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_int_2d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  integer(kind=4), dimension(:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_int_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_int_2d


!===============================================================================
!> Define a global ADIOS 1D int array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_int_3d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  integer(kind=4), dimension(:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_int_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_int_3d


!===============================================================================
!> Define a global ADIOS 1D int array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_int_4d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  integer(kind=4), dimension(:,:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_int_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_int_4d


!===============================================================================
!> Define a global ADIOS 1D int array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_int_5d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  integer(kind=4), dimension(:,:,:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_int_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_int_5d


!===============================================================================
!> Define a long integer global array in ADIOS regardless of the array shape
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param local_dim The local dimension of the array.
  subroutine define_adios_global_1d_long_generic(adios_group, group_size_inc, array_name, local_dim)

  use adios_write_mod, only: adios_define_var,adios_long

  implicit none

  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  ! Variables
  integer(kind=8) :: var_id

  ! Define the dimensions of the array. local_dim used as a dummy
  ! variable to call the integer routine.
  call define_adios_global_dims_1d(adios_group, group_size_inc, trim(array_name), local_dim)

  call adios_define_var(adios_group, "array", trim(array_name), adios_long, &
                        trim(array_name) // "/local_dim", &
                        trim(array_name) // "/global_dim", &
                        trim(array_name) // "/offset", var_id)

  group_size_inc = group_size_inc + local_dim * 8

  end subroutine define_adios_global_1d_long_generic

!===============================================================================
!> Define a global ADIOS 1D long array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_long_1d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  integer(kind=8), dimension(:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_long_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_long_1d


!===============================================================================
!> Define a global ADIOS 1D long array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_long_2d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  integer(kind=8), dimension(:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_long_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_long_2d


!===============================================================================
!> Define a global ADIOS 1D int array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_long_3d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  integer(kind=8), dimension(:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_long_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_long_3d


!===============================================================================
!> Define a global ADIOS 1D int array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_long_4d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  integer(kind=8), dimension(:,:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_long_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_long_4d


!===============================================================================
!> Define a global ADIOS 1D long array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_long_5d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  integer(kind=8), dimension(:,:,:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_long_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_long_5d

!===============================================================================
!> Define a logical global array in ADIOS regardless of the array shape
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param local_dim The local dimension of the array.
  subroutine define_adios_global_1d_logical_generic(adios_group, group_size_inc, array_name, local_dim)

  use adios_write_mod, only: adios_define_var,adios_integer

  implicit none

  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  ! Variables
  integer(kind=8) :: var_id

  ! Define the dimensions of the array. local_dim used as a dummy
  ! variable to call the integer routine.
  call define_adios_global_dims_1d(adios_group, group_size_inc, array_name, local_dim)

  ! The Fortran standard does not specify how variables of LOGICAL type are
  ! represented, beyond requiring that LOGICAL variables of default kind
  ! have the same storage size as default INTEGER and REAL variables.
  ! Hence the 'adios_integer' (2) data type to store logical values
  call adios_define_var(adios_group, "array", trim(array_name), adios_integer, &
                        trim(array_name) // "/local_dim", &
                        trim(array_name) // "/global_dim", &
                        trim(array_name) // "/offset", var_id)

  group_size_inc = group_size_inc + local_dim * 4

  end subroutine define_adios_global_1d_logical_generic

!===============================================================================
!> Define a global ADIOS 1D logical array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_logical_1d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  logical, dimension(:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_logical_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_logical_1d


!===============================================================================
!> Define a global ADIOS 1D logical array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_logical_2d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  logical, dimension(:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_logical_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_logical_2d


!===============================================================================
!> Define a global ADIOS 1D logical array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_logical_3d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  logical, dimension(:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_logical_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_logical_3d


!===============================================================================
!> Define a global ADIOS 1D logical array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_logical_4d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  logical, dimension(:,:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_logical_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_logical_4d


!===============================================================================
!> Define a global ADIOS 1D logical array and autoincrement the adios
!! group size.
!! \param adios_group The adios group where the variables belongs
!! \param group_size_inc The inout adios group size to increment
!!                       with the size of the variable
!! \param local_dim The local dimension of the array.
!! \param path The path where array name lie.
!! \param array_name The variable to be defined. This is actually the path for
!!                   ADIOS. The values are stored in array_name/array
!! \param var The variable to define. Used for type and shape inference.
!! \note This function define local, global and offset sizes as well as the
!!       array to store the values in.
  subroutine define_adios_global_1d_logical_5d(adios_group, group_size_inc,local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  logical, dimension(:,:,:,:,:), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'
  if (len_trim(array_name) == 0) then
    print *,'Error adios: invalid path in adios_helpers_definitions, provides only: ',trim(full_name)
    stop 'Error adios: invalid path in adios_helpers_definitions()'
  endif

  call define_adios_global_1d_logical_generic(adios_group, group_size_inc, trim(full_name), local_dim)

  ! to avoid compiler warnings
  idummy = size(var)

  end subroutine define_adios_global_1d_logical_5d

!===============================================================================

!string added
  subroutine define_adios_global_1d_string_generic(adios_group, group_size_inc, array_name, local_dim)

  use adios_write_mod, only: adios_define_var,adios_string

  implicit none

  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  ! Variables
  integer(kind=8) :: var_id

  ! Define the dimensions of the array. local_dim used as a dummy
  ! variable to call the integer routine.
  call define_adios_global_dims_1d(adios_group, group_size_inc, array_name,local_dim)

  call adios_define_var(adios_group, "array", trim(array_name), adios_string, &
                        trim(array_name) // "/local_dim", &
                        trim(array_name) // "/global_dim", &
                        trim(array_name) // "/offset", var_id)

  group_size_inc = group_size_inc + local_dim * 1

  end subroutine define_adios_global_1d_string_generic

!===============================================================================

  subroutine define_adios_global_1d_string_1d(adios_group, group_size_inc, local_dim, path, array_name, var)

  implicit none
  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  character(len=*), intent(in) :: var
  ! Local vars
  character(len=256) :: full_name
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'

  !print *,"full name: ", trim(full_name)," local_dim: ",local_dim

  call define_adios_global_1d_string_generic(adios_group, group_size_inc,full_name, local_dim)

  ! to avoid compiler warnings
  idummy = len(var)

  end subroutine define_adios_global_1d_string_1d

!
!------------
!

  subroutine  define_adios_local_1d_string_1d(adios_group, group_size_inc, local_dim, path, array_name, var)

  use adios_write_mod, only: adios_define_var,adios_string

  implicit none

  ! Parameters
  integer(kind=8), intent(in) :: adios_group
  character(len=*), intent(in) :: path, array_name
  integer(kind=8), intent(in) :: local_dim
  integer(kind=8), intent(inout) :: group_size_inc
  character(len=*), intent(in) :: var
  ! Local
  character(len=256) :: full_name
  integer(kind=8) :: var_id
  integer :: idummy

  ! sets full variable name
  full_name = trim(path) // trim(array_name)

  ! checks name
  if (len_trim(full_name) == 0) stop 'Error adios: invalid full_name in adios_helpers_definitions()'

  !print *,"in define local:"
  !print *,"full_name:", trim(full_name)

  call adios_define_var(adios_group, array_name, path, adios_string, '', '', '', var_id )

  group_size_inc = group_size_inc + local_dim * 1

  ! to avoid compiler warnings
  idummy = len(var)

  end subroutine define_adios_local_1d_string_1d

end module adios_helpers_definitions_mod
