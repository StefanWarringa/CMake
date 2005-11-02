#
# Check if the function exists.
#
# CHECK_LIBRARY_EXISTS - macro which checks if the function exists
# LIBRARY - the name of the library you are looking for
# FUNCTION - the name of the function
# LOCATION - location where the library should be found
# VARIABLE - variable to store the result
#
# If CMAKE_REQUIRED_FLAGS is set then those flags will be passed into the
# compile of the program likewise if CMAKE_REQUIRED_LIBRARIES is set then
# those libraries will be linked against the test program


MACRO(CHECK_LIBRARY_EXISTS LIBRARY FUNCTION LOCATION VARIABLE)
  IF("${VARIABLE}" MATCHES "^${VARIABLE}$")
    SET(MACRO_CHECK_LIBRARY_EXISTS_DEFINITION 
      "-DCHECK_FUNCTION_EXISTS=${FUNCTION} ${CMAKE_REQUIRED_FLAGS}")
    MESSAGE(STATUS "Looking for ${FUNCTION} in ${LIBRARY}")
    SET(CHECK_LIBRARY_EXISTS_LIBRARIES ${LIBRARY})
    IF(CMAKE_REQUIRED_LIBRARIES)
      SET(CHECK_LIBRARY_EXISTS_LIBRARIES 
        ${CHECK_LIBRARY_EXISTS_LIBRARIES} ${CMAKE_REQUIRED_LIBRARIES})
    ENDIF(CMAKE_REQUIRED_LIBRARIES)
    TRY_COMPILE(${VARIABLE}
      ${CMAKE_BINARY_DIR}
      ${CMAKE_ROOT}/Modules/CheckFunctionExists.c
      CMAKE_FLAGS 
      -DCOMPILE_DEFINITIONS:STRING=${MACRO_CHECK_LIBRARY_EXISTS_DEFINITION}
      -DLINK_DIRECTORIES:STRING=${LOCATION}
      "-DLINK_LIBRARIES:STRING=${CHECK_LIBRARY_EXISTS_LIBRARIES}"
      OUTPUT_VARIABLE OUTPUT)

    IF(${VARIABLE})
      MESSAGE(STATUS "Looking for ${FUNCTION} in ${LIBRARY} - found")
      SET(${VARIABLE} 1 CACHE INTERNAL "Have library ${LIBRARY}")
      FILE(APPEND ${CMAKE_BINARY_DIR}/CMakeFiles/CMakeOutput.log 
        "Determining if the function ${FUNCTION} exists in the ${LIBRARY} "
        "passed with the following output:\n"
        "${OUTPUT}\n\n")
    ELSE(${VARIABLE})
      MESSAGE(STATUS "Looking for ${FUNCTION} in ${LIBRARY} - not found")
      SET(${VARIABLE} "" CACHE INTERNAL "Have library ${LIBRARY}")
      FILE(APPEND ${CMAKE_BINARY_DIR}/CMakeFiles/CMakeError.log 
        "Determining if the function ${FUNCTION} exists in the ${LIBRARY} "
        "failed with the following output:\n"
        "${OUTPUT}\n\n")
    ENDIF(${VARIABLE})
  ENDIF("${VARIABLE}" MATCHES "^${VARIABLE}$")
ENDMACRO(CHECK_LIBRARY_EXISTS)
