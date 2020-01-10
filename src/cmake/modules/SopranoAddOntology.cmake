#
# Macro soprano_add_ontology adds source files generated via Soprano's onto2vocabularyclass tool
# to the specified sources list.
# The files are generated in the current binary dir
#
# soprano_add_ontology( SOURCES
#            ONTOLOGY_FILE
#            ONTOLOGY_NAME
#            NAMESPACE
#            ENCODING
#            [VISIBLITY VISIBILITY_NAME]
# )
#
# As an optional argument one can add VISIBILITY <visibility-name>
#
# Example:
#  soprano_add_ontology(pimo_LIB_SRCS ${PIMO_TRIG_SOURCE} "PIMO" "Nepomuk::Vocabulary" "trig" VISIBILITY "nepomuk")
#
# Copyright (C) 2009 Sebastian Trueg <trueg@kde.org>
#

MACRO(SOPRANO_ADD_ONTOLOGY _sources _ontoFile _ontoName _namespace _encoding)
  # extract optional visibility argument
  set(_args ${ARGN})
  list(GET _args 0 _arg0)
  list(GET _args 1 _arg1)

  if(${_arg0} STREQUAL "VISIBILITY")
    set(_visibility "--export-module" ${_arg1})
  else(${_arg0} STREQUAL "VISIBILITY")
    set(_visibility "--no-visibility-export")
  endif(${_arg0} STREQUAL "VISIBILITY")

  string(TOLOWER ${_ontoName} _ontoFilePrefix)
  set(_ontoHeaderFile "${CMAKE_CURRENT_BINARY_DIR}/${_ontoFilePrefix}.h")
  set(_ontoSourceFile "${CMAKE_CURRENT_BINARY_DIR}/${_ontoFilePrefix}.cpp")

  add_custom_command(OUTPUT ${_ontoHeaderFile} ${_ontoSourceFile}
    COMMAND onto2vocabularyclass --name ${_ontoName} --encoding ${_encoding} --namespace ${_namespace} ${_visibility} ${_ontoFile}
    MAIN_DEPENDENCY ${_ontoFile}
    DEPENDS ${_ontoFile}
    )

  list(APPEND ${_sources} ${_ontoSourceFile})
ENDMACRO(SOPRANO_ADD_ONTOLOGY)
