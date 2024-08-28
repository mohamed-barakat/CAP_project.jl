# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

##
@InstallMethod( AsObjectInWrapperCategory,
        "for a wrapper CAP category and a CAP object",
        [ IsWrapperCapCategory, IsCapCategoryObject ],
        
  function( D, object )
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( object, ModelingCategory( D ), [ "the object given to AsObjectInWrapperCategory" ] );
    
    return CreateCapCategoryObjectWithAttributes( D,
                                                  UnderlyingCell, object );
    
end );

##
@InstallMethod( AsMorphismInWrapperCategory,
        "for two CAP objects in a wrapper category and a CAP morphism",
        [ IsWrapperCapCategoryObject, IsCapCategoryMorphism, IsWrapperCapCategoryObject ],
        
  function( source, morphism, range )
    
    return AsMorphismInWrapperCategory( CapCategory( source ), source, morphism, range );
    
end );

##
@InstallMethod( AsMorphismInWrapperCategory,
        "for two CAP objects in a wrapper category and a CAP morphism",
        [ IsWrapperCapCategory, IsWrapperCapCategoryObject, IsCapCategoryMorphism, IsWrapperCapCategoryObject ],
        
  function( D, source, morphism, range )
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( morphism, ModelingCategory( D ), [ "the morphism given to AsMorphismInWrapperCategory" ] );
    
    if (@not IsEqualForObjects( ModelingCategory( D ), ObjectDatum( D, source ), Source( morphism ) ))
        Error( "ObjectDatum( source ) and Source( morphism ) do not coincide\n" );
    end;
    
    if (@not IsEqualForObjects( ModelingCategory( D ), ObjectDatum( D, range ), Range( morphism ) ))
        Error( "ObjectDatum( range ) and Range( morphism ) do not coincide\n" );
    end;
    
    return CreateCapCategoryMorphismWithAttributes( D,
                                                    source,
                                                    range,
                                                    UnderlyingCell, morphism );
    
end );

##
InstallMethodWithCache( AsMorphismInWrapperCategory,
        "for a wrapper CAP category and a CAP morphism",
        [ IsWrapperCapCategory, IsCapCategoryMorphism ],
        
  function( D, morphism )
    
    return AsMorphismInWrapperCategory(
                   AsObjectInWrapperCategory( D, Source( morphism ) ),
                   morphism,
                   AsObjectInWrapperCategory( D, Range( morphism ) )
                   );
    
end );

##
@InstallMethod( /,
        "for an object and a wrapper CAP category",
        [ IsObject, IsWrapperCapCategory ],
        
  function( data, C )
    
    return ( data / ModelingCategory( C ) ) / C;
    
end );

##
@InstallMethod( /,
        "for a CAP category object and a wrapper CAP category",
         [ IsCapCategoryObject, IsWrapperCapCategory ],
        
  function( object, cat )
    
    if (@not IsIdenticalObj( CapCategory( object ), ModelingCategory( cat ) ))
        TryNextMethod( );
    end;
    
    return AsObjectInWrapperCategory( cat, object );
    
end );

##
@InstallMethod( /,
        "for a CAP category morphism and a wrapper CAP category",
        [ IsCapCategoryMorphism, IsWrapperCapCategory ],
        
  function( morphism, cat )
    
    if (@not IsIdenticalObj( CapCategory( morphism ), ModelingCategory( cat ) ))
        TryNextMethod( );
    end;
    
    return AsMorphismInWrapperCategory( cat, morphism );
    
end );

##
@InstallMethod( WrapperCategory,
        "for a CAP category and a record of options",
        [ IsCapCategory, IsRecord ],
        
  function( C, options )
    local known_options_with_filters, filter, reinterpretation_options, option_name;
    
    ## check given options
    known_options_with_filters = @rec(
        name = IsString,
        category_filter = IsFilter,
        category_object_filter = IsFilter,
        category_morphism_filter = IsFilter,
        only_primitive_operations = IsBool,
    );
    
    for option_name in RecNames( options )
        
        if (@IsBound( known_options_with_filters[option_name] ))
            
            filter = known_options_with_filters[option_name];
            
            if (@not filter( options[option_name] ))
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "The value of the option `", option_name, "` must lie in the filter ", filter );
                
            end;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "The following option is not known to `WrapperCategory`: ", option_name );
            
        end;
        
    end;
    
    reinterpretation_options = @rec(
        object_datum_type = CapJitDataTypeOfObjectOfCategory( C ),
        morphism_datum_type = CapJitDataTypeOfMorphismOfCategory( C ),
        object_constructor = ( cat, d ) -> AsObjectInWrapperCategory( cat, d ),
        object_datum = ( D, o ) -> UnderlyingCell( o ),
        morphism_constructor = ( D, s, d, t ) -> AsMorphismInWrapperCategory( D, s, d, t ),
        morphism_datum = ( D, m ) -> UnderlyingCell( m ),
        modeling_tower_object_constructor = ( D, d ) -> d,
        modeling_tower_object_datum = ( D, o ) -> o,
        modeling_tower_morphism_constructor = ( D, s, d, t ) -> d,
        modeling_tower_morphism_datum = ( D, m ) -> m,
    );
    
    if (@IsBound( options.name ))
        
        reinterpretation_options.name = options.name;
        
    elseif (HasName( C ))
        
        reinterpretation_options.name = @Concatenation( "WrapperCategory( ", Name( C ), " )" );
        
    end;
    
    if (@IsBound( options.category_filter ))
        
        if (@not IsSpecializationOfFilter( IsWrapperCapCategory, options.category_filter ))
            
            Error( "<options.category_filter> must imply IsWrapperCapCategory" );
            
        end;
        
        reinterpretation_options.category_filter = options.category_filter;
        
    else
        
        reinterpretation_options.category_filter = IsWrapperCapCategory;
        
    end;
    
    if (@IsBound( options.category_object_filter ))
        
        if (@not IsSpecializationOfFilter( IsWrapperCapCategoryObject, options.category_object_filter ))
            
            Error( "<options.category_object_filter> must imply IsWrapperCapCategoryObject" );
            
        end;
        
        reinterpretation_options.category_object_filter = options.category_object_filter;
        
    else
        
        reinterpretation_options.category_object_filter = IsWrapperCapCategoryObject;
        
    end;
    
    if (@IsBound( options.category_morphism_filter ))
        
        if (@not IsSpecializationOfFilter( IsWrapperCapCategoryMorphism, options.category_morphism_filter ))
            
            Error( "<options.category_morphism_filter> must imply IsWrapperCapCategoryMorphism" );
            
        end;
        
        reinterpretation_options.category_morphism_filter = options.category_morphism_filter;
        
    else
        
        reinterpretation_options.category_morphism_filter = IsWrapperCapCategoryMorphism;
        
    end;
    
    if (@IsBound( options.only_primitive_operations ))
        
        reinterpretation_options.only_primitive_operations = options.only_primitive_operations;
        
    end;
    
    return ReinterpretationOfCategory( C, reinterpretation_options );
    
end );

##
@InstallMethod( WrappingFunctor,
        "for a wrapper category",
        [ IsWrapperCapCategory ],
        
  function( W )
    
    return ReinterpretationFunctor( W );
    
end );

##################################
##
## View & Display
##
##################################

##
@InstallMethod( DisplayString,
        "for an object in a wrapper CAP category",
        [ IsWrapperCapCategoryObject ],
        
  function( a )
    
    return @Concatenation( DisplayString( ObjectDatum( a ) ), "\nAn object in ", Name( CapCategory( a ) ), " given by the above data\n" );
    
end );

##
@InstallMethod( DisplayString,
        "for a morphism in a wrapper CAP category",
        [ IsWrapperCapCategoryMorphism ],
        
  function( phi )
    
    return @Concatenation( DisplayString( MorphismDatum( phi ) ), "\nA morphism in ", Name( CapCategory( phi ) ), " given by the above data\n" );
    
end );
