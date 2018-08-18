#!/bin/env python

# Copyright Nils Deppe, 2017
# Distributed under the Boost Software License - Version 1.0

# Boost Software License - Version 1.0 - August 17th, 2003

# Permission is hereby granted, free of charge, to any person or organization
# obtaining a copy of the software and accompanying documentation covered by
# this license (the "Software") to use, reproduce, display, distribute,
# execute, and transmit the Software, and to prepare derivative works of the
# Software, and to permit third-parties to whom the Software is furnished to
# do so, all subject to the following:

# The copyright notices in the Software and this entire statement, including
# the above license grant, this restriction and the following disclaimer,
# must be included in all copies of the Software, in whole or in part, and
# all derivative works of the Software, unless such copies or derivative
# works are solely in the form of machine-executable object code generated by
# a source language processor.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
# SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
# FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

import os

import ycm_core

default_flags = ['-x', 'c++', '-Wall', '-Wextra', '-Werror', '-std=c++14','-I/usr/include/c++/5']

cpp_source_extensions = ['.cpp', '.cxx', '.cc', '.c', '.m', '.mm']

header_file_extensions = ['.h', '.H', '.hxx', '.hpp', '.hh']

completion_database = []


def FindCompilationDatabaseAndDir(my_dir):
    """
    Returns the directory the ycm compilation database was found in,
    and the database. Returns None if no compilation database was found.
    This assumes that any compilation database found in the hierarchy is
    the one we want. That is, it assumes projects are not nested.
    """
    while my_dir != '/':
        if os.path.isfile(os.path.join(my_dir, "compile_commands.json")):
            return [my_dir, ycm_core.CompilationDatabase(my_dir)]
        my_dir = os.path.dirname(my_dir)
    return None


def ReloadCompilationDatabase(my_dir):
    """
    Returns the compilation database at 'my_dir/compile_commands.json'
    """
    if os.path.isfile(os.path.join(my_dir, "compile_commands.json")):
        return ycm_core.CompilationDatabase(my_dir)
    return None


def IsHeaderFile(filename):
    """
    Returns true if the file has a header file extension
    """
    extension = os.path.splitext(filename)[1]
    return extension in header_file_extensions


def GetAnyCompilationInfo(dirname, db):
    """
    Returns the compilation info for some file in the directory
    dirname
    """
    source_files_in_dir = list(filter(
        (lambda name: os.path.splitext(name)[1] in cpp_source_extensions),
        os.listdir(dirname)))
    if source_files_in_dir:
        filename = dirname + '/' + source_files_in_dir[0]
        compilation_info = db.GetCompilationInfoForFile(filename)
        if compilation_info.compiler_flags_:
            print("Getting flags for a header file, "
                  "returning compilation flags for file: ", filename)
            return compilation_info
    return None


def TraverseSubdirsExcept(dir_to_traverse, not_this_dir, db,
                          db_root_dir='',
                          jump_up_dir_if_failed=False):
    """
    Traverses all sub directories searching for compilation flags.
    If jump_up_dir_if_failed is True then the next higher level in
    the directory hierarchy is searched as long is it is still in
    the project.
    """
    subdirs = [os.path.abspath(dir_to_traverse + '/' + x)
               for x in next(os.walk(dir_to_traverse))[1]]
    if os.path.abspath(not_this_dir) in subdirs:
        subdirs.remove(os.path.abspath(not_this_dir))
    # Try find compilation flags in each subdir, so a breadth first
    # search
    for subdir in subdirs:
        compilation_info = GetAnyCompilationInfo(subdir, db)
        if not compilation_info is None:
            return compilation_info
    # If we failed to find any flags in the subdirs then:
    # For each subdir, search its subdirs
    for subdir in subdirs:
        compilation_info = TraverseSubdirsExcept(subdir, '', db)
        if not compilation_info is None:
            return compilation_info
    # If requested we go up a directory unless we are already at the
    # project root directory/where the compile_commands.json file is.
    if jump_up_dir_if_failed:
        if db_root_dir not in os.path.split(dir_to_traverse)[0]:
            print("ERROR: Failed to find any compilation flags for a "
                  "header file. The compilation database directory is "
                  "\n  %s" % (db_root_dir))
            return None
        # Try getting flags from one directory up, otherwise traverse
        # directories
        return GetAnyCompilationInfo( os.path.split(dir_to_traverse)[0], db) \
            or TraverseSubdirsExcept(
                os.path.split(dir_to_traverse)[0],
                dir_to_traverse, db,
                db_root_dir,
                jump_up_dir_if_failed)
    return None



def GetCompilationInfoForFile(filename, dir_of_db, db):
    """
    The compilation_commands.json file generated by CMake does not have entries
    for header files. So we do our best by asking the db for flags for a
    corresponding source file, if any. If one exists, the flags for that file
    should be good enough.
    """
    if not IsHeaderFile(filename):
        return db.GetCompilationInfoForFile(filename)

    # Try to find flags for header files so we get completion there
    basename = os.path.splitext(filename)[0]
    # Check all possible cpp extensions to see if a file exists with that
    # extension
    for extension in cpp_source_extensions:
        replacement_file = basename + extension
        if os.path.exists(replacement_file):
            compilation_info = db.GetCompilationInfoForFile(
                replacement_file)
            if compilation_info.compiler_flags_:
                return compilation_info
    # If we couldn't find an entry with a source file extension instead
    # of a header file extension we find any source file in the directory
    # and use those flags, since they should still be quite close to what
    # we need.
    # or
    # Traverse all sub directories first searching for compilation flags.
    # If none are found we start searching upward in the directory tree
    # to find flags. At each level we search all sub directories that we
    # haven't already searched. This is exhaustive and is nearly
    # guaranteed to find useful compilation flags.
    return GetAnyCompilationInfo(os.path.split(filename)[0], db) \
        or TraverseSubdirsExcept(os.path.split(filename)[0],
                                 '',
                                 db,
                                 dir_of_db,
                                 True)


def FlagsForFile(filename, **_):
    """
    Returns the flags needed to compile the file. If a compilation database
    exists then the flags are retrieved from there, otherwise the default
    flags are used.

    Note: This function is only called by ycmd if no flags have been loaded
    for the file. Once flags are loaded it is not called again. Or at least
    that appears to be the behavior.

    Important Note: If precompiled headers are not working then the libclang
    used by ycmd is different than the system libclang. The solution seems
    to be setting ycmd to use the system libclang.
    """
    def basic_flags():
        """Returns the default flags if no database is found"""
        return {'flags': list(default_flags),
                'include_paths_relative_to_dir': os.path.split(filename)[0]}
    # Check if there is a database candidate for this file
    dir_and_db = next((db for db in completion_database if db[0] in filename),
                      None)

    # If no database candidate is found, try to load a database,
    # otherwise return the basic flags
    if dir_and_db is None:
        db_candidate = FindCompilationDatabaseAndDir(
            os.path.split(filename)[0])
        if db_candidate is None:
            return basic_flags()
        completion_database.append(db_candidate)
        dir_and_db = db_candidate

    # Check if file can be found in compilation database, if not, try
    # refreshing the database. Refreshing is used to handle files being
    # added to a project.
    compilation_info = GetCompilationInfoForFile(filename,
                                                 dir_and_db[0],
                                                 dir_and_db[1])

    # Refresh compilation database
    if compilation_info is None:
        dir_and_db = ReloadCompilationDatabase(dir_and_db[0])
        compilation_info = GetCompilationInfoForFile(
            filename, dir_and_db[0], dir_and_db[1])

    if compilation_info is None:
        # We could not find flags for the file even though it is in a
        # sub-directory of the directory that the database is in. This is
        # taken as meaning that the user has not yet added the file to the
        # project's build system and we should try loading flags again
        # later. By return "None" we signal to YCMD that it should later
        # try loading the flags again.
        return None

    return {'flags': list(compilation_info.compiler_flags_),
            'include_paths_relative_to_dir':
            compilation_info.compiler_working_dir_}
